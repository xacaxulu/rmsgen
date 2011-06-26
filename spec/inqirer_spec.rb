require 'rmsgen'
require 'fake_gets'
require 'rspec'

describe Rmsgen::Inquirer do
  describe "inquires about a note with indented" do
    let(:note) { "foo\n\nhttp://\n\n   bar"}
    subject { Rmsgen::Inquirer.new(note) }
    
    before do
      $stdin = FakeGetMany.new("foo")
    end
    
    it "merges the url" do
      exp = "<a href='http://'>foo</a> bar\n\n"
      subject.to_s.should == exp
    end
  end

  describe "it inquires about each link in a note" do
    let(:note) { "foo\n\nhttp://\n\nbar\n\nhttp://" }
    subject { Rmsgen::Inquirer.new(note) }

    before do
      $stdin = FakeGetMany.new("foo", "bar")
    end

    it "inquires about each url" do
      exp = "<a href='http://'>foo</a>\n\n<a href='http://'>bar</a>"
      subject.to_s.should == exp 
    end
  end
end
