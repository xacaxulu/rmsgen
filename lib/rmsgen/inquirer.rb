module Rmsgen
  class Inquirer
    def initialize(raw, stdout=$stdout)
      @parts = PartGroup.new(raw)
      @stdout = stdout
      @new = []
      run!
    end

    def last
      @new[-1]
    end

    def put_part(part)
      @stdout.puts last
      @stdout.puts
    end

    def linkify(part)
      put_part(part)
      text = ask_for_text(part)
      last.gsub!(text, %{<a href='#{part}'>#{text}</a>})
    end

    def prompt_for_polnote_link(part)
      prompt = part[1..-2] + ":\n"
      @stdout.puts prompt
      @stdout.puts
      ask_for_text(prompt)
    end

    def run!
      @parts.each_with_index do |part, i|
        if part.include?('http')
          linkify(part)
        elsif part =~ /\[Link/
          @parts.insert(i+1, prompt_for_polnote_link(part))
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
