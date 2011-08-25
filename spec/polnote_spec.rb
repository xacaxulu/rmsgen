require 'rmsgen'

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
end
