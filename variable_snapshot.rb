class VariableSnapshot
  attr_accessor(:w)
  attr_accessor(:x)
  attr_accessor(:y)
  attr_accessor(:z)

  def initialize
    @w = 0
    @x = 0
    @y = 0
    @z = 0
  end

  def print
    puts "Result:"
    puts "x = #{@x}, y = #{@y}, w = #{@w}, and z = #{@z}"
  end
end
