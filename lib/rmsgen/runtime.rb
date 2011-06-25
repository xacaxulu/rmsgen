module Rmsgen
  class Runtime
    def initialize(config)
      @config = config
      @email_dir = @config["email_dir"]
      run!
    end

    def run!
      process_notes do |note|
        note.compress
        note.inquire
        puts note.to_html
      end
    end

    private

    def process_notes
      Dir["#{@email_dir}/*"].each do |note|
        yield Polnote.new(File.read(note))
      end
    end
  end
end
