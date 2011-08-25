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

  it "splits input into parts based on carriage return and newline" do
    input = "1\r\n\r\n2\r\n\r\n3\r\n\r\n4"
    p = PartGroup.new(input)
    p.should == ['1', '2', '3', '4']
  end
end
