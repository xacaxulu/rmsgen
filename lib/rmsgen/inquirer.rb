module Rmsgen
  class Inquirer
    def initialize(raw, stdout=$stdout)
      @raw_split = raw.split("\n\n")
      @stdout = stdout
      @new = []
      run!
    end

    def run!
      @raw_split.each_with_index do |part, i|
        last = @new[-1]
        if part.include?('http')
          @stdout.puts last
          @stdout.puts
          text = ask_for_text(part)
          last.gsub!(text, %{<a href='#{part}'>#{text}</a>})
        elsif part =~ /\[Link/
          prompt = part[1..-2] + ":\n"
          @stdout.puts prompt
          @stdout.puts
          text = ask_for_text(prompt)
        elsif part =~ /^   /
          last << " #{part.strip}\n\n"
        else
          @new << part
        end
      end
    end

    def ask_for_text(part)
      @stdout.puts "What is the text?" 
      $stdin.gets.chomp
    end

    def to_s
      @new.join("\n\n")
    end
  end
end
