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
end
