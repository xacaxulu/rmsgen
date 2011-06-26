module Rmsgen
  class Inquirer
    def initialize(raw)
      @raw_split = raw.split("\n\n")
      @new = []
      run!
    end

    def run!
      @raw_split.each_with_index do |part, i|
        if part.include?('http')
          puts @new[-1]
          puts
          text = ask_for_text(part).chomp
          @new[-1].gsub!(text, %{<a href='#{part}'>#{text}</a>})
        elsif part =~ /^   /
          @new[-1] << " #{part.strip}\n\n"
        else
          @new << part
        end
      end
    end

    def ask_for_text(part)
      puts "What is the text?" 
      $stdin.gets
    end

    def to_s
      @new.join("\n\n")
    end
  end
end
