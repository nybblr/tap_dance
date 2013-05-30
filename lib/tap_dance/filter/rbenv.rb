module TapDance
  module Filter
    class Rbenv
      attr_reader :version

      def initialize(version)
        @version = version
      end
    end
  end
end
