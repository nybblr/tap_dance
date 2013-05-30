module TapDance
  module Filter
    class Env
      attr_reader :name
      attr_reader :value

      def initialize(name, value)
        @name = name
        @value = value
      end
    end
  end
end
