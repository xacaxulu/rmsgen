module Rmsgen
  class Script
    def initialize(stdout=$stdout)
      @stdout = stdout
    end

    def prompt_for_expiry_date
      prompt "What day does it expire? ex) 08 July 2011:\n "
    end

    def prompt_for_text
      prompt "What is the text?"
    end

    def prompt_for_polnote_link part 
      label = part[1..-2] + "?:\n"
      prompt("What is the #{label}")
    end

    def prompt_for_title
      prompt "Type title:"
    end

    def announce message 
      @stdout.puts message
      @stdout.puts
    end

    private

    def prompt(label)
      announce label
      input = $stdin.gets.chomp
      @stdout.puts
      input
    end
  end
end
