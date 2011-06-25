module Rmsgen
  class Polnote
    attr_accessor :title, :body
    attr_reader :raw

    def initialize(raw)
      @raw = raw
      @body = raw
    end

    def compress
      @body = Compresser.new(@body).to_s
    end

    def encode
    end

    def titleize
    end

    def inquire
      @body = Inquirer.new(@body).to_s
    end

    def write
      $stdout.puts @body
    end
  end
end
