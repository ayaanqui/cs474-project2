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
end