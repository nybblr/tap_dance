require 'bindler/brew'
require 'bindler/tap'

module Bindler
  class Definition
    attr_accessor :taps
    attr_accessor :brews

    def initialize(taps, brews)
      @taps = taps
      @brews = brews
    end
  end
end
