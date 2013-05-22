require 'bindler/brew'
require 'bindler/tap'
require 'bindler/dsl'

require 'thor'

module Bindler
  class Bindle < Thor
    package_name "Bindler"
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

      Bindler.ui = UI::Shell.new(options)
      Bindler.ui.level = "debug" if options["verbose"]

      Bindler.ui.info "Brewing from #{@brewfile}"

      unless File.exist? @brewfile
        Bindler.ui.error "Nothing to brew! No Brewfile found."
      end
    end

    desc "install", "install all the brews in your Brewfile"
    def install
      return unless File.exist? @brewfile
      @definition = Bindler::Dsl.evaluate @brewfile
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
