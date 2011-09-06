module Rmsgen
  class FsPolnoteGroup
    def initialize(dir=nil)
      splat_dir = "#{dir}/*"
      @raw_notes = Dir[splat_dir].map { |f| File.read(f) }
      @notes = @raw_notes.map { |note| Rmsgen::Polnote.new(note) }
    end
    def all
      @notes
    end
  end
end
