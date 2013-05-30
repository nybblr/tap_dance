require 'string'

module TapDance
  module Filter
    class DSL
      FILTERS = [:env, :rbenv, :rvm]
      FILTERS.each {|f| require "tap_dance/filter/#{f}"}

      attr_reader :filters

      def self.evaluate(&block)
        builder = new
        builder.instance_eval(&block)
        builder.filters
      end

      def initialize
        @filters = []
      end

      def method_missing(method, *args, &block)
        if FILTERS.include? method.to_sym
          # Create a new instance of the filter and pass on the args
          @filters << Filter.const_get(method.to_s.camelize).send(:new, *args, &block)
        else
          super
        end
      end

      def respond_to?(method, include_private = false)
        FILTERS.include? method.to_sym || super
      end
    end
  end
end
