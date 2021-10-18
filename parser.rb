class Parser
  def initialize(variables_list, assigners_list, operators_list)
    @variables_list = variables_list
    @assigners_list = assigners_list
    @operators_list = operators_list
  end

  # The syntax of each arithmetic expression conforms to the following four patterns
  # where id can be one of: w, x, y, and z.
  # And op can be one of: +, -, *, **, and /.
  # 1. id = id op id.
  # 2. id = id op constant.
  # 3. id = constant.
  # 4. id ? go int.
  # @param input (String)
  # @return (Expression)
  def parse(input)
    # First split by space
    parsedInput = input.split " "

    line_number = parsedInput[0] # T
    lhs = parsedInput[1]
    assigner = parsedInput[2] # Could be a "=" or "?"

    arg1, arg2, arg3 = nil
    arg1 = parsedInput[3]
    if parsedInput[3..].length == 2
      arg2 = parsedInput[4]
      arg3 = parsedInput[5]
    elsif parsedInput[3..].length == 1
      arg2 = parsedInput[4]
    end

    expression = Expression.new lhs, assigner, arg1
    expression.arg2 = arg2
    expression.arg3 = arg3
    expression
  end
end
