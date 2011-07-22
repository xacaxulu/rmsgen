require 'rmsgen/polnote'

module Rmsgen
  class Runtime
    def initialize(config)
      @config = config
      @email_dir = @config["email_dir"]
      raise "Ensure you have populated a config file" unless @config
      @output = @config["output_file"]
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

    def process_notes
      Dir["#{@email_dir}/*"].each do |note|
        yield Polnote.new(File.read(note))
      end
    end
  end
end
