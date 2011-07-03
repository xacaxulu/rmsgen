module Rmsgen
  class Polnote
    attr_accessor :title, :body, :expires_on
    attr_reader :parts

    URGENT_SUBJECT = 'Subject: Urgent note'

    def initialize(raw)
      @raw = raw
      @body = raw.dup
      @urgent = @raw.include? URGENT_SUBJECT
    end

    def urgent?
      !!@urgent
    end

    def compress
      @body = Compresser.new(self).body
    end

    def titleize
      @title = Titleizer.new(self).body
    end

    def inquire
      @body = Inquirer.new(self).body
    end

    def parts
      PartGroup.new(@body.dup)
    end

    def to_html
      out = ''
      out << "<!-- Expires #{@expires_on} -->\n" if @expires_on
      out << "#{@title}\n"
      part_out = parts.map do |part| 
        if part =~ /<!--/
          "#{part}"
        else
          "<p>#{part}</p>"
        end
      end
      out << part_out.join("\n")
    end
  end
end
