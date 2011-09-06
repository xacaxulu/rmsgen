require 'rmsgen'

describe Rmsgen::FsPolnoteGroup do
  context '.all' do
    context 'when zero polnotes are in the directory' do
      it 'returns an empty collection' do
        empty_dir = 'empty-dir'
        splat_dir = "#{empty_dir}/*"
        Dir.should_receive(:[]).with(splat_dir).and_return([])
        group = Rmsgen::FsPolnoteGroup.new(empty_dir)
        result = group.all
        result.should be_empty
      end
    end

    context 'when one polnote is in the directory' do
      let(:dir) { '/home/foo/dir' }
      let(:splat_dir) { "#{dir}/*" }
      let(:notes) { ['/home/foo/dir/polnote'] }

      before do
        Dir.should_receive(:[]).with(splat_dir).and_return(notes)
        File.should_receive(:read).with(notes.first).and_return("hello world")
        group = Rmsgen::FsPolnoteGroup.new(dir)
        @result = group.all
      end

      it 'returns one element' do
        @result.size.should == 1
      end

      it 'returns a polnote element' do
        @result.first.should be_instance_of(Rmsgen::Polnote)
      end
    end
  end
end
