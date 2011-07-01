require 'rmsgen'
require 'fake_gets'
require 'rspec'
require 'stringio'

describe Rmsgen::Inquirer do
  let(:stdout) { StringIO.new }

  describe "inquires about a note which is indented" do
    let(:note) { Rmsgen::Polnote.new("foo\n\nhttp://\n\n   bar") }

    subject { Rmsgen::Inquirer.new(note, stdout) }

    before do
      $stdin = FakeGetMany.new("foo")
    end

    it "merges the url" do
      exp = "<a href='http://'>foo</a> bar\n\n"
      subject.to_s.should == exp
    end
  end

  describe "it inquires about each link in a note" do
    let(:note) { Rmsgen::Polnote.new("foo\n\nhttp://\n\nbar\n\nhttp://") }
    subject { Rmsgen::Inquirer.new(note, stdout) }

    before do
      $stdin = FakeGetMany.new("foo", "bar")
    end

    it "inquires about each url" do
      exp = "<a href='http://'>foo</a>\n\n<a href='http://'>bar</a>"
      subject.to_s.should == exp 
    end
  end

  describe "inquiring about a duration" do
    let(:note) { Rmsgen::Polnote.new("For one week:\n\nUrgent: blah blah blah") }

    subject { Rmsgen::Inquirer.new(note, stdout) }

    before do 
    end

    it "asks for the end date of the duration" do
      $stdin = FakeGetMany.new("Title", "July 1")
      subject.run!
      note.expires_on.should == "July 1"
    end
  end
end
