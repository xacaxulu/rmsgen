module Rmsgen
  class Titleizer
    def initialize(body)
      @body = body
      @tday = Date.today
      @tdayf = @tday.strftime('%d %B %Y')
      @tdayu = @tdayf.gsub(' ', '_')
      run!
    end

    def run!
      get_title
    end

    def get_title
      puts "Type title:"
      puts
      @title = $stdin.gets.chomp
      puts
    end

    def utitle
      @title.gsub(' ', '_')
    end

    def to_html
    "<p><li><a name='#{@tdayu}_(#{utitle})' />#{@tdayf} (<a class='titlelink' href='##{@tdayu}_(#{utitle})'>#{@title}</a>)</p>"
    end
  end
end
