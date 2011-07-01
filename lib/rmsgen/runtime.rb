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
        note.compress
        puts note.body
        puts
        note.titleize
        note.inquire
        puts
        if @output && output = File.open(@output, 'a')
          output.puts note.to_html
          output.puts
          output.close
        else
          puts note.to_html
          puts
        end
      end
    end

    private

    def output
    end

    def process_notes
      Dir["#{@email_dir}/*"].each do |note|
        yield Polnote.new(File.read(note))
      end
    end
  end
end
