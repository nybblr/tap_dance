require 'tap_dance/brew'
require 'tap_dance/tap'
require 'tap_dance/dsl'

require 'thor'

module TapDance
  class Dance < Thor
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

    attr_accessor :brewfile
    attr_accessor :definition

    def initialize(*args, &block)
      super(*args, &block)
      @definition = nil

      # Make sure homebrew is installed
      unless command?(:brew)
        puts "You haven't installed homebrew, or it isn't in your path."
        exit 1
      end

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
        BrewCli.update
      end
    end

    desc "install", "install all the brews in your Brewfile"
    def install
      return unless File.exist? @brewfile
      @definition = TapDance::Dsl.evaluate @brewfile
    end

    desc "update", "update all the brews in your Brewfile"
    def update(name=nil)
      return unless File.exist? @brewfile
    end

  private

    # Note: susceptible to code injection!
    def command?(name)
      system "which #{name.to_s} > /dev/null 2>&1"
    end

  end
end
