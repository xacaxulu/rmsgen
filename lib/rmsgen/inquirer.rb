module Rmsgen
  class Inquirer
    PARTS = { :url => /^http/, 
              :note =>/\[Link/,
              :duration => /^For.*week.*$/,
              :indendation => /^   / 
            }

    def initialize polnote, stdout=$stdout 
      @parts_seen = []
      @polnote    = polnote
      @parts      = @polnote.parts
      @script     = Script.new stdout 
      run!
    end

    def body
      @parts_seen.join PartGroup::DELIMETER 
    end

    private

    def run!
      @parts.each do |part|
        if part =~ PARTS[:duration]
          inquire_about_expiration
        elsif part =~ PARTS[:url]
          inquire_about_link part 
        elsif part =~ PARTS[:note]
          inquire_about_polnote_link part  
        elsif part =~ PARTS[:indendation]
          append_to_previous_paragraph part 
        else
          @parts_seen << part
        end
      end
    end

    def inquire_about_link url 
      @script.announce current_part
      text = @script.prompt_for_text
      link = Link.new text, url
      current_part.gsub! text, link.to_s 
    end

    def inquire_about_expiration
      @polnote.expires_on = @script.prompt_for_expiry_date
    end

    def append_to_previous_paragraph part 
      current_part << " #{part.strip}#{PartGroup::DELIMETER}"
    end

    def current_part
      @parts_seen.last
    end

    def inquire_about_polnote_link part 
      href = @script.prompt_for_polnote_link part 
      text = @script.prompt_for_text
      link = Link.new text, href 
      current_part.gsub! text, link.to_s
    end
  end
end
