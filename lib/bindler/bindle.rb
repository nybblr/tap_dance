require 'bindler/brew'
require 'bindler/tap'

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

    attr_accessor :brews
    attr_accessor :taps
    attr_accessor :brewfile

    def initialize(*args, &block)
      super(*args, &block)
      @brews = []
      @taps = []

      # Make sure homebrew is installed
      unless command?(:brew)
        puts "You haven't installed homebrew, or it isn't in your path."
        exit 1
      end

      # Find brewfile
      @brewfile = options["brewfile"]
      @brewfile ||= "./Brewfile"
      @brewfile = File.expand_path @brewfile
    end

    desc "install", "install all the brews in your Brewfile"
    def install
      puts "Brewing from #{@brewfile}"
    end

    desc "update", "update all the brews in your Brewfile"
    def update(name=nil)
      return "goodbye world!"
    end

  private

    # Note: susceptible to code injection!
    def command?(name)
      system "which #{name.to_s} > /dev/null 2>&1"
    end
  end
end
