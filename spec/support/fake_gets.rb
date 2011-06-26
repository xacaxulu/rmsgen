class FakeGet
  def initialize(input)
    @in = input
  end
  def gets
    @in
  end
end

class FakeGetMany 
  attr_reader :answers
  
  def initialize(*answers)
    @answers = answers
    @count = 0
  end

  def answer
    @answers.shift
  end

  def gets
    @count += 1
    answer
  end
end

