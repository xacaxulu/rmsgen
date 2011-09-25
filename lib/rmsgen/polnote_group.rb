module Rmsgen
  module PolnoteGroup
    def self.fetch(source)
      polnote_group = group(source)
      polnote_group.all
    end


    private

    def self.group(source)
      if source.is_a?(String)
        Rmsgen::FsPolnoteGroup.new(source) 
      elsif source.is_a?(Hash)
        Rmsgen::IMAPPolnoteGroup.new(source)
      end
    end
  end
end
