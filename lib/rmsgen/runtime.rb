module Rmsgen
  class Runtime
   
    def initialize(config)
      @config = config
      raise "Ensure you have populated a config file" unless @config
      @output = config['output_file']
      @source_directory_or_imap_options = polnote_source
      @notes = fetch_notes 
      run!
    end

    def run!
      puts 'no polnotes in queue' if @notes.empty?
      @notes.each do |note|
        system('clear')
        polnote = Rmsgen::Polnote.new(:body => note)
        Rmsgen::Inquirer.inquire_about_note(polnote)
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

    def polnote_source
      @config['email_dir'] || imap_options
    end

    def imap_options  
      { 
        'imap_server' => @config['imap_server'],
        'imap_login' => @config['imap_login'],
        'imap_password' => @config['imap_password'] 
      }
    end

    def fetch_notes
      PolnoteGroup.fetch(@source_directory_or_imap_options)
    end
  end
end
