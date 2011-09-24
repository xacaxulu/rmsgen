require 'forwardable'

class PartGroup
  extend Forwardable
  include Comparable

  # Carriage return new line.
  #
  CRNL        = /\r\n/
  CRNL_CRNL   = /\r\n\r\n/
  DELIMETER   = "\n\n"
  NL          = /\n/
  NL_NL       = /\n\n/
  NL_PLACEHOLDER = '[newline]'
  SPACE       = ' '

  attr_reader :text, :parts

  def_delegators :@parts, :delete_if, :<<, :each, :join, 
    :inject, :each_with_index, :[], :map, :size

  def initialize(text)
    @text = text
    @parts = []
    assign_parts!
  end

  def <=>(other)
    parts.map(&:to_s) <=> other.map(&:to_s)
  end

  private

  def assign_parts!
    massage_linebreaks
    parts = @text.split(DELIMETER)
    assign_parsed_parts(parts)
    @parts.delete_if(&:empty?)
  end

  def assign_parsed_parts(parts)
    parts.each { |p| @parts << Rmsgen::Part.parse(p) }
  end

  def massage_linebreaks
    @text.gsub!(CRNL_CRNL, DELIMETER)
    @text.gsub!(CRNL, SPACE)
    @text.gsub!(NL_NL, NL_PLACEHOLDER)
    @text.gsub!(NL_PLACEHOLDER, DELIMETER)
  end
end
