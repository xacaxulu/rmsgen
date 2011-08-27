require 'rmsgen/polnote'

module Rmsgen
  class Runtime
    def initialize(config)
      @config = config
      raise "Ensure you have populated a config file" unless @config
      @output = @config['output_file']
      @notes = fetch_notes 
      run!
    end

    def run!
      if @notes
        @notes.each do |note|
          system('clear')
          polnote = Rmsgen::Inquirer.inquire_about_note(note)
          write(polnote)
        end
      else
        puts 'no polnotes in queue'
      end
    end

    private

    def write(note)
      if @output
        File.open(@output, 'a') do |file|
          file.puts note.to_html
        end
      else
        puts note.to_html
        puts
      end
    end

    def fetch_notes
      if @config['email_dir']
        notes = Dir["#{@config['email_dir']}/*"].map { |f| File.read(f) }
      else
        notes = fetch_notes_from_imap
      end
      notes.map { |note| Rmsgen::Polnote.new(note) } if notes
    end

    def fetch_notes_from_imap
      options = { 
        'imap_login' => @config['imap_login'],
        'imap_password' => @config['imap_password'] 
      }

      imap = Net::IMAP.new(@config['imap_server'])
      Rmsgen::IMAPPolnoteGroup.new(imap, options).fetch_notes
    end

  end
end
