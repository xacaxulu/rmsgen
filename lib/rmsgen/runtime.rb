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
      process_notes do |note|
        system('clear')
        puts note.body
        puts
        note.titleize
        note.inquire
        puts
        write(note)
      end
    end

    private

    def write(note)
      output_file = File.open(@output, 'a') if @output
      if output_file
        output_file.puts note.to_html
        output_file.close
      else
        puts note.to_html
        puts
      end
    end

    def fetch_notes
      if @config['email_dir']
        Dir["#{@config['email_dir']}/*"].map { |f| File.read(f) }
      else
        fetch_notes_from_imap
      end
    end

    def fetch_notes_from_imap
      options = { 
        :imap_server => @config['imap_server'],
        :imap_login  => @config['imap_login'],
        :imap_password => @config['imap_password'] 
      }

      imap = Net::IMAP.new(@config['imap_server'])
      Rmsgen::IMAPPolnoteGroup.new(imap, options).fetch_notes
    end

    def process_notes
      @notes.each do |note|
        puts note.inspect
        puts Polnote.new(note).inspect
        yield Polnote.new(note)
      end
    end
  end
end
