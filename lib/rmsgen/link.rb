module Rmsgen
  class Link
    def initialize(text, href)
      @text = text
      @href = href
    end

    def to_s
      %{<a href='#{@href}'>#{@text}</a>}
    end
  end
end
