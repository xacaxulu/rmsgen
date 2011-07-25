module Rmsgen
  class Inquirer
    INDENT_PARAGRAPH_MATCHER = /^   /
    NOTE_MATCHER = /\[Link/
    URL_MATCHER = /^http/
    DURATION_MATCHER = /^For.*week.*$/

    def initialize polnote, stdout=$stdout 
      @parts_seen = []
      @polnote    = polnote
      @parts      = @polnote.parts
      @script     = Script.new stdout 
      run!
    end

    def run!
      @parts.each do |part|
        if part =~ DURATION_MATCHER
          inquire_about_expiration
        elsif part =~ URL_MATCHER
          inquire_about_link part 
        elsif part =~ NOTE_MATCHER
          inquire_about_polnote_link part  
        elsif part =~ INDENT_PARAGRAPH_MATCHER
          append_to_previous_paragraph part 
        else
          inquired_about part 
        end
      end
    end

    def inquire_about_expiration
      @polnote.expires_on = @script.prompt_for_expiry_date
    end

    def inquire_about_link part 
      @script.announce last_part_seen
      text = @script.prompt_for_text
      last_part_seen.gsub!(text, Link.new(text, part).to_s)
    end

    def inquire_about_polnote_link part 
      href = @script.prompt_for_polnote_link part 
      text = @script.prompt_for_text
      last_part_seen.gsub!(text, Link.new(text, href).to_s)
    end

    def append_to_previous_paragraph part 
      last_part_seen << " #{part.strip}#{PartGroup::DELIMETER}"
    end

    def inquired_about part 
      @parts_seen << "#{part}"
    end

    def last_part_seen
      @parts_seen.last
    end

    def body
      @parts_seen.join PartGroup::DELIMETER 
    end
  end
end
