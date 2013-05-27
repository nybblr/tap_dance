require 'tap_dance/ui'
require 'tap_dance/brew_cli'

module TapDance
  class Tap
    attr_accessor :name
    attr_accessor :url

    def initialize(name, url, opts={})
      @name = name.to_sym
      @url  = url.to_s
      @opts = opts
    end

    def entap
      BrewCLI.tap(@url)
    end

    def untap
      BrewCLI.untap(@url)
    end

    def tapped?
      BrewCLI.tap_list.out.each_line { |t|
        return true if @url == t.strip
      }

      return false
    end

    def to_s
      "#{@name}:#{@url}"
    end

  end
end
