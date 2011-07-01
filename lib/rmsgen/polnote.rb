module Rmsgen
  class Polnote
    attr_accessor :title, :body
    attr_reader :raw

    def initialize(raw)
      @raw = raw
      @body = raw.dup
      @parts = PartGroup.new(@body.dup)
    end

    def compress
      @body = Compresser.new(@raw).body
    end

    def encode
    end

    def titleize
      @title = Titleizer.new(@body).to_html
    end

    def inquire
      @body = Inquirer.new(@body).to_s
    end

    def to_html
      @title + "\n" +
      @body.split("\n\n").map { |x| "<p>#{x}</p>" }.join("\n")
    end
  end
end
