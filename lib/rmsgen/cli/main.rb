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
        File.open(config['email_dir']) if config['email_dir']
      end

      def execute!
        Rmsgen::Runtime.new(@config)
      end
    end
  end
end
