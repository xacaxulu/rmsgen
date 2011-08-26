require 'rmsgen'
require 'fake_gets'

describe Rmsgen::Polnote do

  def fixture(name)
    File.read("spec/fixtures/#{name}")
  end

  context "urgent polnote truthfully responds to urgent?" do
    let(:urgent) { fixture(:urgent_note) }  
    let(:polnote) { Rmsgen::Polnote.new(urgent) } 
    
    it "truthfully responds to urgent?" do
      polnote.urgent?.should be true
    end
  end

  context "imap email" do
    let(:imap_note) { fixture(:imap_note) }

    it "has parts" do
      note = Rmsgen::Polnote.new(imap_note)
      note.parts.should == ['hello', 'world']
    end
  end

  context 'a note that requires a link to a polnote' do
    let(:note) { fixture(:link_to_polnote) }

    it 'parses the body' do
      $stdout = StringIO.new
      text_a = "rainbow"
      polnote_url = "http://somenote"
      text_b = "blue"

      $stdin = FakeGetMany.new(text_a, polnote_url, text_b)
      polnote = Rmsgen::Polnote.new(note)
      polnote.inquire
      polnote.to_html.should ==
"""<p>Somewhere over the <a href='http://rainbow.org'>rainbow</a>.</p>
<p>Skys are <a href='http://somenote'>blue</a>.</p>

"""
    end
  end
end
