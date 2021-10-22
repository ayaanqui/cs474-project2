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
    puts "w: " + @w.to_s
    puts "x: " + @x.to_s
    puts "y: " + @y.to_s
    puts "z: " + @z.to_s
  end
end
