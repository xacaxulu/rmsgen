module Rmsgen
  class Titleizer
    DATE_FORMAT = ('%d %B %Y')
    TEMPLATE = File.join(File.dirname(__FILE__), '..', 'templates', 'title.erb')

    attr_reader :title

    def initialize(polnote)
      @body = polnote.body
      @script = Script.new($stdout)
      run!
    end

    def run!
      @title = @script.prompt_for_title
      body
    end

    def today(format=nil)
      @tday ||= Date.today
      if format
        @tday.strftime(format) 
      end
    end

    def today_format
      today(DATE_FORMAT)
    end

    def today_underscore
      today_format.gsub(' ', '_')
    end

    def title_underscore
      @title.gsub(' ', '_')
    end

    def body
      ERB.new(File.read(TEMPLATE)).result(binding)
    end
  end
end
