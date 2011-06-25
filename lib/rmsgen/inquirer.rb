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
          text = ask_for_text(part).chomp
          @new[i-1].gsub!(text, %{<a href='#{part}'>#{text}</a>})
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
      @new
    end
  end
end
