module Rmsgen
  class Inquirer
    DURATION = /^For.*$/

    def initialize(polnote, stdout=$stdout)
      @polnote = polnote
      @parts = @polnote.parts
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
      merge_link(text, part, last)
    end

    def merge_link(text, link, src)
      src.gsub!(text, %{<a href='#{link}'>#{text}</a>})
    end

    def prompt_for_polnote_link(part)
      prompt = part[1..-2] + ":\n"
      @stdout.puts prompt
      @stdout.puts
      ask_for_text(prompt)
    end

    def duration_prompt(part)
      prompt = "What is this date: #{part}? "
      @stdout.puts prompt
      input = $stdin.gets.chomp
      @stdout.puts
      input
    end

    def run!
      @parts.each_with_index do |part, i|
        if part =~ DURATION
          @polnote.expires_on = duration_prompt(part)
        elsif part.include?('http')
          linkify(part)
        elsif part =~ /\[Link/
          link = prompt_for_polnote_link(part)
          text = ask_for_text(last)
          @new[-1] = merge_link(text, link, last)
        elsif part =~ /^   /
          last << " #{part.strip}\n\n"
        else
          @new << "#{part}"
        end
      end
    end

    def ask_for_text(part)
      @stdout.puts "What is the text?" 
      @stdout.puts
      input = $stdin.gets.chomp
      @stdout.puts
      input
    end

    def to_s
      @new.join("\n\n")
    end
  end
end
