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
      puts 'no polnotes in queue' if @notes.empty?
      @notes.each do |note|
        system('clear')
        polnote = Rmsgen::Inquirer.inquire_about_note(note)
        write(polnote)
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
      notes.map { |note| Rmsgen::Polnote.new(:body => note) } if notes
    end

    def fetch_notes_from_imap
      options = { 
        'imap_server' => @config['imap_server'],
        'imap_login' => @config['imap_login'],
        'imap_password' => @config['imap_password'] 
      }

      Rmsgen::IMAPPolnoteGroup.new(options).fetch_notes
    end
  end
end
