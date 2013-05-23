module TapDance
  module BrewCli
    class << self
      # One offing terminal commands makes it easy to stub.
      attr_writer :prefix

      def prefix
        @prefix ||= `brew --prefix`.chomp
      end

      def list_versions
        `brew list --versions #{@name}`
      end

      def formula_info
        `brew info #{@name} 2>&1`
      end

      def tap
        `brew tap @{url} 2>&1`
      end

      def untap
        `brew untap @{url} 2>&1`
      end

      def tap_list
        `brew tap`
      end
    end
  end
end
