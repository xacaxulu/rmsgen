module Rmsgen
  class Titleizer
    TEMPLATE = File.join(File.dirname(__FILE__), '..', 'templates', 'title.erb')

    attr_reader :title

    def initialize(polnote)
      @body = polnote.body
      @script = Script.new($stdout)
      run!
    end

    def body
      ERB.new(File.read(TEMPLATE)).result(binding)
    end

    def today_format
      Date.today.strftime('%d %B %Y')
    end

    def today_underscore
      today_format.gsub(' ', '_')
    end

    def title_underscore
      @title.gsub(' ', '_')
    end

    private
    
    def run!
      @title = @script.prompt_for_title
      body
    end

  end
end
