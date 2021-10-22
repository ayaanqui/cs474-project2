require_relative "./parser"
require_relative "./expression"
require_relative "./variable_snapshot"

class Project2 < Parser
  def initialize
    super(%w[w x y z], %w[= ?], %w[+ - * / **])
  end

  # Returns each line in filename as an element in an array
  # @param filename (String)
  # @return (Array)
  def get_file_data(filename)
    file = File.open filename
    data = file.readlines.map { |line| line.chomp }
    file.close
    data
  end

  def program_loop
    while true
      input = gets
      command = input[0]

      case command
      when "r"
        list = parsed_expression_list
        history = [VariableSnapshot.new]
        list.each do |exp|
          puts exp.expression
          history = eval history, exp
          puts history.last.print
        end
      when "s"
        puts "Run one line at a time."
      when "x"
        break
      else
        puts "Unknown command"
      end

      puts ""
    end
  end

    # @return ([Expression])
  def parsed_expression_list
    data = get_file_data "pc_input.txt"
    parsed_lines = []
    data.each do |line|
      parsed_line = parse line
      parsed_lines.push parsed_line
    end
    parsed_lines
  end

  private

  # @param history (Array)
  # @param expression (Expression)
  # @return []
  def eval(history, expression)
    ex = expression
    case ex.assigner
    when "="
      value = assign_operator expression, history.last
      snapshot = set_value ex.var, value, history.last
      return history.push snapshot
    when "?"
      puts "Loop"
    end
    []
  end


  private

  # @param expression (Expression)
  # @return (Float)
  def assign_operator(expression, prev_snapshot)
    arg1 = value_from_expression_arg expression.arg1, prev_snapshot

    if expression.arg3 != nil
      arg3 = value_from_expression_arg expression.arg3, prev_snapshot
      return condense arg1, arg3, expression.arg2
    end
    arg1
  end

  # @param arg1 (Float)
  # @param arg2 (Float)
  # @param op (String)
  # @return (Float)
  def condense(arg1, arg2, op)
    case op
    when "+"
      return arg1 + arg2
    when "-"
      return arg1 - arg2
    when "*"
      return arg1 * arg2
    when "/"
      return arg1 / arg2
    when "**"
      return arg1 ** arg2
    end
  end

  # @param arg (String or nil)
  # @param expression (Expression)
  # @return (Float)
  def value_from_expression_arg(arg, expression)
    value = Float arg, exception: false
    if value == nil
      value get_value arg, expression
    end
    value
  end

  # @param var (String)
  # @param snapshot (VariableSnapshot)
  # @return (Float)
  def get_value(var, snapshot)
    value = 0
    case var
    when "w"
      value = snapshot.w
    when "x"
      value = snapshot.x
    when "y"
      value = snapshot.y
    when "z"
      value = snapshot.z
    end
    value
  end

  # @param var (String)
  # @param value (Float)
  # @param prev (VariableSnapshot)
  # @return (VariableSnapshot)
  def set_value(var, value, prev)
    v = VariableSnapshot.new
    case var
    when "w"
      v.w = value
      v.x = prev.x
      v.y = prev.y
      v.z = prev.z
    when "x"
      v.w = prev.w
      v.x = value
      v.y = prev.y
      v.z = prev.z
    when "y"
      v.w = prev.w
      v.x = prev.x
      v.y = value
      v.z = prev.z
    when "z"
      v.w = prev.w
      v.x = prev.x
      v.y = prev.y
      v.z = value
    end
    v
  end
end

program = Project2.new
program.program_loop
