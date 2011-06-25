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
          if parent = @new[i-1]
            puts parent
            puts
            text = ask_for_text(part).chomp
            parent.gsub!(text, %{<a href='#{part}'>#{text}</a>})
          end
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
