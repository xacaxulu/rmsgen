require 'rmsgen'
require 'fake_gets'
require 'rspec'
require 'stringio'

describe Rmsgen::Inquirer do
  let(:stdout) { StringIO.new }

  describe "inquires about a note which is indented" do
    let(:note) { Rmsgen::Polnote.new(:body => "foo\n\nhttp://\n\n   bar") }

    subject { Rmsgen::Inquirer.new(note, stdout) }

    before do
      $stdin = FakeGetMany.new("foo")
    end

    it "merges the url" do
      exp = "<a href='http://'>foo</a> bar\n\n"
      subject.body.should == exp
    end
  end

  describe "it inquires about each link in a note" do
    let(:note) { Rmsgen::Polnote.new(:body => "foo\n\nhttp://\n\nbar\n\nhttp://") }
    subject { Rmsgen::Inquirer.new(note, stdout) }

    before do
      $stdin = FakeGetMany.new("foo", "bar")
    end

    it "inquires about each url" do
      exp = "<a href='http://'>foo</a>\n\n<a href='http://'>bar</a>"
      subject.body.should == exp 
    end
  end

  describe "inquiring about a duration" do
    it "asks for the end date of the duration" do
      note = Rmsgen::Polnote.new(:body => "For one week:\n\nUrgent: blah blah blah")
      $stdin = FakeGetMany.new("July 1")
      Rmsgen::Inquirer.new(note, stdout)
      note.expires_on.should be == "July 1"
    end
  end

  describe 'when a blank answer is given' do
    it 'returns the polnote text without links' do
      note = Rmsgen::Polnote.new(:body => "foo bar\n\nhttp://")
      $stdin = FakeGetMany.new("")
      inquirer = Rmsgen::Inquirer.new(note, stdout)
      inquirer.body.should be == "foo bar"
    end
  end
end
