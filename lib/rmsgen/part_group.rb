class PartGroup < Array
  attr_reader :text

  DELIMETER = "\n\n"

  def initialize(text)
    @text = text
    assign_parts!
  end

  def assign_parts!
    if @text.match /\r\n\r\n/
      @text.gsub!(/\r\n\r\n/, "\n\n")
      @text.gsub!(/\r\n/, " ")
    end
    @text.split(DELIMETER).each { |p| self << p }
  end
end
