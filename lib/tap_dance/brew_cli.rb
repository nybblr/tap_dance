require 'tap_dance'

# Load in extensions
require 'hash'
require 'array'

module TapDance
  module BrewCLI
    class << self
      # One offing terminal commands makes it easy to stub.
      attr_accessor :dry_run
      attr_writer :prefix

      def prefix
        @prefix ||= exec("--prefix").strip
      end

      def update
        exec "update", true
      end

      def install(name, flags="")
        exec "install #{name} #{flag_string flags}", true
      end

      def upgrade(name, flags="")
        exec "upgrade #{name} #{flag_string flags}", true
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
        cmd.strip!

        if volatile and @dry_run
          TapDance.ui.warn "Would run: brew #{cmd}"
          return nil
        else
          return `brew #{cmd} 2>&1`
        end
      end

      # Sanitize flags with standard unix
      # conventions and generate a string
      def flag_string(flags)
        case flags
        when String
          return flags
        else
          return flags.squash("-").map {|m|
            case m
            when /^--/
              m
            when /^-[^\-]/
              m
            else
              if m =~ /^.[ =]/
                "-#{m}"
              else
                "--#{m}"
              end
            end
          }.join(" ")
        end
      end
    end
  end
end
