module Rmsgen
  class FsPolnoteGroup
    def initialize(dir=nil)
      @note_bodies = note_bodies_from_directory(dir)
      @notes = build_many_polnotes(@note_bodies)
    end

    def all
      @notes
    end

    private

    def note_bodies_from_directory(dir)
      Dir["#{dir}/*"].map { |f| File.read(f) }
    end

    def build_many_polnotes(note_bodies)
      note_bodies.map { |body| Rmsgen::Polnote.new(:body => body)  }
    end
  end
end
