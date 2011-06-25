module Rmsgen
  class Compresser
    def initialize(raw)
      @raw_split = raw.split("\n\n")
      @inf = @raw_split.join("\n\n")
      run!
    end

    def run!
      rm_header
      rm_footer
    end

    def rm_header
    end

    def rm_footer
    end

    def to_s
      @raw_split.join("\n\n")    
    end
  end
end
