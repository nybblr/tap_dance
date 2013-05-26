require 'tap_dance/brew'
require 'tap_dance/tap'

module TapDance
  class Definition
    attr_accessor :taps
    attr_accessor :brews

    def initialize(taps=[], brews=[])
      @taps = taps
      @brews = brews
    end

    def tap(name, url, opts={})
      @taps << Tap.new(name, url, opts.merge(:definition => self))
      @taps.last
    end

    def brew(name, opts={})
      @brews << Brew.new(name, opts.merge(:definition => self))
      @brews.last
    end

    def tap_named(name)
      @taps.find { |t| t.name.to_s == name.to_s }
    end

    def execute(upgrade=false)
      @taps.each(&:entap)
      unless upgrade
        @brews.each(&:install)
      else
        @brews.each(&:upgrade)
      end
    end
  end
end
