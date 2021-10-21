class Expression
  attr_accessor(:expression)
  attr_accessor(:line_number)
  attr_accessor(:var)
  attr_accessor(:assigner)
  attr_accessor(:arg1)
  attr_accessor(:arg2)
  attr_accessor(:arg3)

  def initialize(expression, line_number, var, assigner, arg1)
    @expression = expression
    @line_number = line_number
    @var = var
    @assigner = assigner
    @arg1 = arg1
    @arg2 = nil
    @arg3 = nil
  end

  def print
    puts "Expression: " + @expression
    puts "Line number: " + @line_number
    puts "Left hand side: " + @var
    puts "Assigner: " + @assigner
    puts "Arg 1: " + @arg1
    if @arg2 != nil
      puts "Arg 2: " + @arg2
    end
    if @arg3 != nil
      puts "Arg 3: " + @arg3
    end
  end
end
