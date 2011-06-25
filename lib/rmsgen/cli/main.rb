require 'rmsgen'

module Rmsgen
  module Cli
    class Main
      def self.execute(config, args)
        new(config, args).execute!
      end

      def initialize(config, args)
        @config = config
        @args = args
      end

      def execute!
        Rmsgen::Runtime.new(@config)
      end
    end
  end
end
