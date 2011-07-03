module Rmsgen
  class Polnote
    TEMPLATE = Rmsgen.template_path + '/polnote.erb'

    attr_reader :parts
    attr_accessor :title, :body, :expires_on

    URGENT_SUBJECT = 'Subject: Urgent note'

    def initialize(source)
      @body   = source.dup
      @urgent = source.include? URGENT_SUBJECT
      compress
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
      ERB.new(File.read(TEMPLATE)).result(binding)
    end
  end
end
