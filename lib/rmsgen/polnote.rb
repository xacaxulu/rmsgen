module Rmsgen
  class Polnote
    attr_accessor :id, :title, :body, :expires_on

    URGENT_SUBJECT = 'Subject: Urgent note'
    TEMPLATE = File.join(File.dirname(__FILE__), '..', 'templates', 'polnote.erb')

    def initialize(source, options={})
      @body   = source.dup
      @urgent = source.include? URGENT_SUBJECT
      @id     = options[:id]
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
      ERB.new(File.read(TEMPLATE)).result(binding)
    end

    private

    def compress!
      @body = Compresser.new(self).body
    end
  end
end
