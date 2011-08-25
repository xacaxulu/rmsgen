module Rmsgen
  class Compresser
    def initialize(polnote)
      @polnote = polnote
      @parts = polnote.parts
      run!
    end

    def body
      @parts.join PartGroup::DELIMETER
    end

    private

    def run!
      rm_header
      rm_footer
      single_line_paragraphs
    end

    def rm_header
      @parts.delete_if { |x| x =~ /Return-Path:/ }
    end

    def rm_footer
      @parts.delete_if { |x| x =~ /Dr Richard Stallman/ } 
    end

    def single_line_paragraphs
      @parts.each do |part|
        part.gsub!("\n", '')
      end
    end

  end
end
