module Rmsgen
  class Compresser
    def initialize(raw)
      @raw = raw
      @split = raw.split("\n\n")
      rm_header
      rm_footer
    end

    def rm_header
      @split.delete_at(0) if @split[0] =~ /Return-Path:/
    end

    def rm_footer
      @split.delete_at(-1) if @split[-1] =~ /Dr Richard Stallman/
    end

    def body
      @split.join("\n\n")
    end
  end
end
