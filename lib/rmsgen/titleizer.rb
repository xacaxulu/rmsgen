module Rmsgen
  class Titleizer
    def initialize(body)
      @body = body
      run!
    end

    def run!
      get_title
    end

    def get_title
      puts "Type title:"
      puts
      @title = $stdin.gets.chomp
    end

    def utitle
      @title.gsub(' ', '_')
    end

    def to_html
    "<p><li><a name=\"02_April_2011_(#{utitle})\" />02 April 2011 (<a class=\"titlelink\" href=\"#02_April_2011_(#{utitle})\">#{@title}</a>)</p>"
    end
  end
end
