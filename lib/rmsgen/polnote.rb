module Rmsgen
  class Polnote
    attr_accessor :title, :body
    attr_reader :raw

    def initialize(raw)
      @raw = raw
      @body = raw.dup
    end

    def compress
      @body = Compresser.new(@raw).body
    end

    def encode
    end

    def titleize
    end

    def inquire
      @body = Inquirer.new(@body).to_s
    end

    def write
      puts @body
    end

    def to_html
      @body.split("\n\n").map { |x| "<p>#{x}</p>" }.join("\n")
    end
  end
end
