require 'forwardable'

module ActsLike
  module String
    extend Forwardable

    def initialize(str='')
      @str = str
    end

    def_delegators :@str, :to_s, :gsub!, :[], :strip, :<<, :empty?
  end
end
