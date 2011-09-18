module Rmsgen
  class Polnote
    attr_accessor :id, :title, :body, :expires_on

    URGENT_SUBJECT = 'Subject: Urgent note'

    POLNOTE_TEMPLATE = File.join(File.dirname(__FILE__), '..', 'templates', 'polnote.erb')
    URGENT_TEMPLATE = File.join(File.dirname(__FILE__), '..', 'templates', 'urgent.erb')

    def initialize(attributes={})
      @body   = attributes[:body]
      @urgent = sanitize_urgent_attribute(attributes[:urgent]) || (@body && @body.include?(URGENT_SUBJECT))
      @id     = attributes[:id]
      compress!
    end

    def urgent?
      @urgent
    end

    def titleize
      @title = Titleizer.new(self).body
    end

    def inquire
      @body = Inquirer.new(self).body
    end

    def parts
      PartGroup.new(@body)
    end

    def to_html
      ERB.new(File.read(POLNOTE_TEMPLATE)).result(binding)
    end

    def to_urgent_html
      ERB.new(File.read(URGENT_TEMPLATE)).result(binding)
    end

    private

    def compress!
      @body = Compresser.new(self).body
    end

    def sanitize_urgent_attribute(attribute)
      return false if attribute == 'false'
      return true if attribute == 'true'
      attribute
    end
  end
end
