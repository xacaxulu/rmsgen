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
      @text.gsub!(/\n\n\n\n/, "")
    else
      @text.gsub!(/\n\n/, '[newline]')
      @text.gsub!(/\n/, ' ')
      @text.gsub!('[newline]', "\n\n")
    end
    @text.split(DELIMETER).delete_if(&:empty?).each { |p| self << p }
  end
end
