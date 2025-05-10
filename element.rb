
class Element
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def compare_to(element)
    fail "This message should be overwritten"
  end

end

