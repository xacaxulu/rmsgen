require 'rmsgen'
require 'fake_gets'

describe Rmsgen::Polnote do
  def fixture(name)
    File.read("spec/fixtures/#{name}")
  end

  context "urgent polnote truthfully responds to urgent?" do
    let(:urgent) { fixture(:urgent_note) }  
    let(:polnote) { Rmsgen::Polnote.new(:body => urgent) } 

    it "truthfully responds to urgent?" do
      polnote.urgent?.should be true
    end
  end

  context "imap email" do
    let(:imap_note) { fixture(:imap_note) }

    it "has parts" do
      note = Rmsgen::Polnote.new(:body => imap_note)
      note.parts.size.should be == 2
    end
  end

  context 'a note that requires a link to a polnote' do
    let(:note) { fixture(:link_to_polnote) }

    it 'parses the body' do
      $stdout = StringIO.new
      $stdin = FakeGetMany.new('rainbow', 'http://somenote', 'blue')
      polnote = Rmsgen::Polnote.new(:body => note)
      polnote.inquire
      polnote.to_html.should ==
        %Q{<p>Somewhere over the <a href='http://rainbow.org'>rainbow</a>.</p>
<p>Skys are <a href='http://somenote'>blue</a>.</p>\n\n}
    end
  end


  context 'a multiline note' do
    let(:multiline_note) { fixture(:multiline_note) }

    it 'replaces single new lines with a space' do
      $stdout = StringIO.new
      text_a = "Somewhere"
      text_b = "Candy"
      $stdin = FakeGetMany.new(text_a, text_b)
      polnote = Rmsgen::Polnote.new(:body => multiline_note)
      polnote.inquire
      polnote.to_html.should == "<p> <a href='http://unicorns.org'>Somewhere</a> over the rainbow skies are blue</p>\n<p>Candy is sweet and unicorns are too</p>\n\n"
    end
  end
end
