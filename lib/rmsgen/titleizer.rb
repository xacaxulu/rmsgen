module Rmsgen
  class Titleizer
    SPACE = ' '
    UNDERSCORE = '_'

    TEMPLATE = File.join(File.dirname(__FILE__), '..', 'templates', 'title.erb')

    attr_reader :title

    def initialize(polnote, options={})
      @title   = options[:title]
      @body    = polnote.body
      @script  = Script.new($stdout)
      run!
    end

    def to_html
      ERB.new(File.read(TEMPLATE)).result(binding)
    end

    private

    def run!
      @title = capitalize(get_title_from_options_or_script)
    end

    def capitalize(str)
      str.split(SPACE).map(&:capitalize).join(SPACE)
    end

    def get_title_from_options_or_script
      @title || @script.prompt_for_title
    end

    def today_format
      Date.today.strftime('%d %B %Y')
    end

    def today_underscore
      today_format.gsub(SPACE, UNDERSCORE)
    end

    def title_underscore
      @title.gsub(SPACE, UNDERSCORE)
    end
  end
end
