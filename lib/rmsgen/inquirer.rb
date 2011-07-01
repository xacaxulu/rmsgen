module Rmsgen
  class Inquirer
    INDENT_PARAGRAPH_MATCHER = /^   /
    NOTE_MATCHER = /\[Link/
    URL_MATCHER = /^http/
    DURATION_MATCHER = /^For.*week.*$/

    class Script
      EXPIRY = "What day does it expire? ex) 08 July 2011:\n "
      TEXT   = "What is the text?"

      def initialize(stdout=$stdout)
        @stdout = stdout
      end

      def prompt_for_expiry_date
        prompt(EXPIRY)
      end

      def prompt_for_text
       prompt "What is the text?" 
      end

      def prompt_for_polnote_link(part)
        label = part[1..-2] + ":\n"
        @stdout.puts label
        @stdout.puts
        prompt(label)
      end

      def prompt(label)
        @stdout.puts label
        @stdout.puts
        input = $stdin.gets.chomp
        @stdout.puts
        input
      end
    end

    def initialize(polnote, stdout=$stdout)
      @polnote = polnote
      @parts = @polnote.parts
      @stdout = stdout
      @inquiries = []
      @script = Script.new(stdout)
      run!
    end

    def run!
      @parts.each do |part|
        if part =~ DURATION_MATCHER
          @polnote.expires_on = @script.prompt_for_expiry_date
        elsif part =~ URL_MATCHER
          linkify(part)
        elsif part =~ NOTE_MATCHER
          polnotify(part) 
        elsif part =~ INDENT_PARAGRAPH_MATCHER
          append(part)
        else
          inquired_about(part)
        end
      end
    end

    def linkify(part)
      put_last
      text = @script.prompt_for_text
      merge_link(text, part, last)
    end

    def polnotify(part)
      link = @script.prompt_for_polnote_link(part)
      text = @script.prompt_for_text
      @inquiries[-1] = merge_link(text, link, last)
    end

    def append(part)
      last << " #{part.strip}\n\n"
    end

    def put_last
      @stdout.puts last
      @stdout.puts
    end

    def last
      @inquiries.last
    end

    def inquired_about(part)
      @inquiries << "#{part}"
    end

    def merge_link(text, link, src)
      src.gsub!(text, %{<a href='#{link}'>#{text}</a>})
    end

    def to_s
      @inquiries.join("\n\n")
    end
  end
end
