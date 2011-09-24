require 'rmsgen'

describe Rmsgen::Parts::PlainText do
  context 'behaving like a string' do
    it 'returns the input string' do
      p = Rmsgen::Parts::PlainText.new('foo')
      p.to_s.should == 'foo'
    end
  end
end

describe Rmsgen::Parts::PolnoteUrlRequest do
  context 'behaving like a string' do
    it 'returns the input string' do
      p = Rmsgen::Parts::PolnoteUrlRequest.new('foo')
      p.to_s.should == 'foo'
    end
  end
end

describe Rmsgen::Part do
  context 'parse' do
    it 'detects a url' do
      Rmsgen::Part.parse('http').should be_instance_of(Rmsgen::Parts::Url)
    end

    it 'detects the headers' do
      Rmsgen::Part.parse('Return-Path:').should be_instance_of(Rmsgen::Parts::Header)
    end

    it 'detects an indented line' do
      Rmsgen::Part.parse('   hello world').should be_instance_of(Rmsgen::Parts::IndentedLine)
    end

    it 'detects a duration' do
      Rmsgen::Part.parse('For one week').should be_instance_of(Rmsgen::Parts::Duration)
    end

    it 'detects plain text' do
      Rmsgen::Part.parse('bla blah blah').should be_instance_of(Rmsgen::Parts::PlainText)
    end

    it 'detects a polnote url request' do
      Rmsgen::Part.parse('[Link to a polnote]').should be_instance_of(Rmsgen::Parts::PolnoteUrlRequest)
    end
  end
end
