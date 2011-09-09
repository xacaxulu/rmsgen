module Rmsgen
  class Inquirer
    PARTS = { :url => /^http/, 
      :note =>/\[Link/,
        :duration => /^For.*week.*$/,
        :indendation => /^   / 
    }

    attr_reader :polnote

    def initialize polnote, stdout=$stdout, answers=nil
      @parts_seen = []
      @polnote    = polnote
      @parts      = @polnote.parts
      @stdout     = stdout
      @script     = Script.new(stdout)
      @answers    = answers ||= []
      run!
    end

    def body
      @parts_seen.join PartGroup::DELIMETER 
    end

    def self.inquire_about_note(note, stdout=$stdout)
      stdout.puts note.body
      stdout.puts
      note.titleize
      note.inquire
      stdout.puts
      note
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
      if @answers.empty?
        @script.announce current_part
        text = @script.prompt_for_text
      else
        text = @answers.shift
      end
      if text && !text.empty?
        link = Link.new text, url
        current_part.gsub! text, link.to_s 
      end
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
      if @answers.any?
        href = @answers.shift
        text = @answers.shift
      else
        href = @script.prompt_for_polnote_link part 
        @script.announce current_part
        text = @script.prompt_for_text
      end
      link = Link.new text, href 
      current_part.gsub! text, link.to_s
    end
  end
end
