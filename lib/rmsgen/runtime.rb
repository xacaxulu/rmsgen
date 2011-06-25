module Rmsgen
  class Runtime
    def initialize(config)
      @config = config
      run!
    end

    def run!
      process_notes do |note|
        note.encode
        note.compress
        note.inquire
        note.write
      end
    end

    private

    def process_notes
      Dir["#{@config["email_dir"]}/*"].each do |note|
        yield Polnote.new(File.read(note))
      end
    end
  end
end
