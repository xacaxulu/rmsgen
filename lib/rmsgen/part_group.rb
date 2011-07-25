class PartGroup < Array
  attr_reader :text

  DELIMETER = "\n\n"

  def initialize(text)
    @text = text
    assign_parts!
  end

  def assign_parts!
    @text.split(DELIMETER).each { |p| self << p }
  end
end
