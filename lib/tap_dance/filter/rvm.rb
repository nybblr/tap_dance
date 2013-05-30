module TapDance
  module Filter
    class Rvm
      attr_reader :version

      def initialize(version)
        @version = version
      end
    end
  end
end
