class Expression
  attr_accessor(:var)
  attr_accessor(:assigner)
  attr_accessor(:arg1)
  attr_accessor(:arg2)
  attr_accessor(:arg3)

  def initialize(var, assigner, arg1)
    @var = var
    @assigner = assigner
    @arg1 = arg1
    @arg2 = nil
    @arg3 = nil
  end

  def print
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
