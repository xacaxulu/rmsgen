class PartGroup < Array
  attr_reader :text

  def initialize(text)
    @text = text
    assign_parts!
  end

  def assign_parts!
    @text.split("\n\n").each { |p| self << p }
  end
end
