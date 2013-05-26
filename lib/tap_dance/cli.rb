require 'tap_dance'
require 'tap_dance/brew'
require 'tap_dance/tap'
require 'tap_dance/dsl'

require 'thor'

module TapDance
  class CLI < Thor
    package_name "TapDance"
    default_task "install"

    class_option "verbose",
      :type => :boolean,
      :banner => "Enable verbose output mode",
      :aliases => "-v"
    class_option "brewfile",
      :type => :string,
      :banner => "Specify an alternate path to a Brewfile",
      :aliases => "-B"
    class_option "dry-run",
      :type => :boolean,
      :banner => "Print out what volatile commands would be run"

    attr_accessor :brewfile
    attr_accessor :definition

    def initialize(*args, &block)
      super(*args, &block)

      # Make sure homebrew is installed
      unless command?(:brew)
        puts "You haven't installed homebrew, or it isn't in your path."
        exit 1
      end

      @definition = nil

      # Activate dry-run mode
      TapDance::BrewCLI.dry_run = options["dry-run"] if options["dry-run"]

      # Find brewfile
      @brewfile = options["brewfile"]
      @brewfile ||= "./Brewfile"
      @brewfile = File.expand_path @brewfile

      TapDance.ui = UI::Shell.new(options)
      TapDance.ui.level = "debug" if options["verbose"]

      TapDance.ui.info "Brewing from #{@brewfile}"

      unless File.exist? @brewfile
        TapDance.ui.error "Nothing to brew! No Brewfile found."
      else
        TapDance.ui.info "Running `brew update` for good measure."
        BrewCLI.update
      end
    end

    desc "install", "install all the brews in your Brewfile"
    def install
      return unless File.exist? @brewfile
      @definition = TapDance::DSL.evaluate @brewfile
      @definition.execute
    end

    desc "update", "update all the brews in your Brewfile"
    def update(name=nil)
      return unless File.exist? @brewfile
      @definition = TapDance::DSL.evaluate @brewfile
      @definition.execute true
    end

  private

    # Note: susceptible to code injection!
    def command?(name)
      system "which #{name.to_s} > /dev/null 2>&1"
    end

  end
end
