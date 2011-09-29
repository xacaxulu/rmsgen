module Rmsgen
  module PolnoteGroup
    def self.fetch(source)
      polnote_group = group(source)
      polnote_group.all
    end


    private

    def self.group(source)
      case source
      when String then Rmsgen::FsPolnoteGroup.new(source) 
      else
        Rmsgen::IMAPPolnoteGroup.new(source)
      end
    end
  end
end
