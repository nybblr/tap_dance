require 'tap_dance'

module TapDance
  module BrewCLI
    class << self
      # One offing terminal commands makes it easy to stub.
      attr_accessor :dry_run
      attr_writer :prefix

      def prefix
        @prefix ||= exec("--prefix").chomp
      end

      def update
        exec "update", true
      end

      def install(name, flags="")
        exec "install #{name} #{flags}", true
      end

      def list_versions(name)
        exec "list --versions #{name}"
      end

      def formula_info(name)
        exec "info #{name}"
      end

      def tap(url)
        exec "tap #{url}", true
      end

      def untap(url)
        exec "untap #{url}", true
      end

      def tap_list
        exec "tap"
      end

    private

      # Private because we want
      # all brew commands wrapped
      # for testing.
      def exec(cmd, volatile=false)
        # If a command is volatile (causes system changes),
        # we want to offer a dry-run option for testing
        # and the CLI.

        if volatile and @dry_run
          TapDance.ui.warn "Would run: brew #{cmd}"
          return nil
        else
          return `brew #{cmd} 2>&1`
        end
      end

    end
  end
end
