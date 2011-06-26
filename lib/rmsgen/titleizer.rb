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

    def to_html
    "<p><li><a name=\"02_April_2011_(The_Title)\" />02 April 2011 (<a class=\"titlelink\" href=\"#02_April_2011_(The_Title)\">The Title</a>)</p>"
    end
  end
end
