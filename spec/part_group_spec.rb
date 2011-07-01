require 'rmsgen'

describe PartGroup do
  it "accepts text as input" do
    input = "hello\n\nworld"
    p = PartGroup.new(input)
    p.text.should be == input
  end

  it "output list of parts ordered by appearance" do
    input = "1\n\n2\n\n3\n\n4"
    p = PartGroup.new(input)
    p.should == ['1', '2', '3', '4']
  end
end
