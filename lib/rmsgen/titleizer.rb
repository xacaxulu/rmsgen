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

    private
    
    def run!
      @title = @script.prompt_for_title
      body
    end

  end
end
