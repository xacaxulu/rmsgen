module Rmsgen
  class Compresser
    def initialize(part_group=[])
      @part_group = part_group
      run!
    end

    def body
      @part_group.join PartGroup::DELIMETER
    end

    private

    def run!
      rm_header
      rm_footer
      single_line_paragraphs
    end

    def rm_header
      @part_group.delete_if { |x| x.is_a?(Rmsgen::Parts::Header) }
    end

    def rm_footer
      @part_group.delete_if { |x| x.is_a?(Rmsgen::Parts::Footer) }
    end

    def single_line_paragraphs
      @part_group.each { |part| part.gsub!("\n", ' ') }
    end
  end
end
