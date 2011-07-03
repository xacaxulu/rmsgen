module Rmsgen
  class Inquirer
    INDENT_PARAGRAPH_MATCHER = /^   /
    NOTE_MATCHER = /\[Link/
    URL_MATCHER = /^http/
    DURATION_MATCHER = /^For.*week.*$/

    def initialize(polnote, stdout=$stdout)
      @inquiries = []
      @polnote   = polnote
      @parts     = @polnote.parts
      @script    = Script.new(stdout)
      run!
    end

    def run!
      @parts.each do |part|
        if part =~ DURATION_MATCHER
          update_expiry
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

    def update_expiry
      @polnote.expires_on = @script.prompt_for_expiry_date
    end

    def linkify(part)
      @script.say(@inquiries.last)
      merge_link(@script.prompt_for_text, part, @inquiries.last)
    end

    def polnotify(part)
      link = @script.prompt_for_polnote_link(part)
      merge_link(@script.prompt_for_text, link, @inquiries.last)
    end

    def append(part)
      @inquiries.last << " #{part.strip}\n\n"
    end

    def inquired_about(part)
      @inquiries << "#{part}"
    end

    def merge_link(text, link, src)
      src.gsub!(text, %{<a href='#{link}'>#{text}</a>})
    end

    def body
      @inquiries.join("\n\n")
    end
  end
end
