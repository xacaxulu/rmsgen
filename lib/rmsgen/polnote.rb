module Rmsgen
  class Polnote
    attr_accessor :title, :body, :expires_on
    attr_reader :raw, :parts

    URGENT_SUBJECT = 'Subject: Urgent note'

    def initialize(raw)
      @raw = raw
      @body = raw.dup
      @parts = PartGroup.new(@body.dup)
      @urgent = @raw.include? URGENT_SUBJECT
    end

    def urgent?
      !!@urgent
    end

    def compress
      @body = Compresser.new(self).body
    end

    def encode
    end

    def titleize
      @title = Titleizer.new(@body).to_html
    end

    def inquire
      @body = Inquirer.new(self).to_s
    end

    def to_html
      out = ''
      out << "<!-- Expires #{@expires_on} -->\n" if @expires_on
      out << "#{@title}\n"
      parts = @body.split("\n\n").map do |part| 
        if part =~ /<!--/
          "#{part}"
        else
          "<p>#{part}</p>"
        end
      end
      out << parts.join("\n")
    end
  end
end
