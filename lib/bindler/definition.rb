require 'bindler/brew'
require 'bindler/tap'

module Bindler
  class Definition
    attr_accessor :taps
    attr_accessor :brews

    def initialize(taps=[], brews=[])
      @taps = taps
      @brews = brews
    end

    def tap(name, opts={})
      @taps << Tap.new(name, opts)
    end

    def brew(name, opts={})
      @taps << Brew.new(name, opts)
    end
  end
end
