class Parser
  MAX_LEN = 6 # Maximum length of parsed input
  
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
    # Remove period at the end if exists
	  input = strip_period(input)

	  # First split by space
    parsedInput = input.split " "

    line_number = strip_period parsedInput[0]
    expression = parsedInput[1..]

    lhs = expression[0]
    assigner = expression[1] # Could be a "=" or "?"

    arg1, arg2, arg3 = nil
    arg1 = expression[2]
    if parsedInput.length == MAX_LEN
      arg2 = expression[3]
      arg3 = expression[4]
    elsif parsedInput.length == MAX_LEN-1
      arg2 = expression[3]
    end

    expression = Expression.new expression.join(" "), line_number, lhs, assigner, arg1
    expression.arg2 = arg2
    expression.arg3 = arg3
    expression
  end


  private

  def strip_period(input)
    len = input.length
    if input[len-1] == "."
      return input[0..(len-2)]
    end
    input
  end
end
