require_relative "./parser"
require_relative "./expression"
require_relative "./variable_snapshot"

class Project2 < Parser
  def initialize
    @expression_list = []
    @program_execution = []
    @loop_counter = 0
    @i = 0

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
    @expression_list = []
    @program_execution = []
    @loop_counter = 0
    @i = 0

    while true
      input = gets
      command = input[0]

      case command
      when "r"
        @expression_list = parsed_expression_list
        @program_execution = @expression_list.dup

        history = [VariableSnapshot.new]
        @i = 0
        while true do
          if @i >= @program_execution.length
            break
          end

          exp = @program_execution[@i]
          puts "#{exp.line_number}: #{exp.expression}"
          eval_return = eval history, exp
          if eval_return != nil
            history = eval_return
            puts history.last.print
          end
          @i += 1
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

    # @return (Array)
  def parsed_expression_list
    data = get_file_data "pc_input.txt"
    parsed_lines = []
    data.each do |line|
      parsed_line = parse line
      parsed_lines.push parsed_line
    end
    parsed_lines
  end

  # @param history (Array)
  # @param expression (Expression)
  # @return []
  def eval(history, expression)
    ex = expression
    prev_snapshot = history.last
    case ex.assigner
    when "="
      value = assign_operator expression, prev_snapshot
      snapshot = set_value ex.var, value, prev_snapshot
      return history.push snapshot
    when "?"
      loop ex, prev_snapshot
      return history.push prev_snapshot
    else
      return nil
    end
  end


  private

  # @param expression (Expression)
  # @param prev_snapshot (VariableSnapshot)
  # @return (Float)
  def assign_operator(expression, prev_snapshot)
    arg1 = value_from_expression_arg expression.arg1, prev_snapshot

    if expression.arg3 != nil
      arg3 = value_from_expression_arg expression.arg3, prev_snapshot
      return condense arg1, arg3, expression.arg2
    end
    arg1
  end

  # @param expression (Expression)
  # @param prev_snapshot (VariableSnapshot)
  # @return (Boolean)
  def loop(expression, prev_snapshot)
    var = value_from_expression_arg expression.var, prev_snapshot
    line = value_from_expression_arg expression.arg1, prev_snapshot

    exp_line_number = Integer expression.line_number, exception: false
    if exp_line_number == nil
      return false
    end

    if var == 0
      ret_val = false
    else
      loop_expression_list = @expression_list[line-1..]
      @program_execution = @program_execution[0..@i] + loop_expression_list
      ret_val = true
    end
    ret_val
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
    else
      return nil
    end
  end

  # @param arg (String or nil)
  # @param expression (Expression)
  # @return (Float)
  def value_from_expression_arg(arg, expression)
    value = Float arg, exception: false
    if value == nil
      value = get_value arg, expression
    end
    value
  end

  # @param var (String)
  # @param snapshot (VariableSnapshot)
  # @return (Float)
  def get_value(var, snapshot)
    case var
    when "w"
      value = snapshot.w
    when "x"
      value = snapshot.x
    when "y"
      value = snapshot.y
    when "z"
      value = snapshot.z
    else
      value = 0
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
    else
      return v
    end
    v
  end
end

program = Project2.new
program.program_loop
