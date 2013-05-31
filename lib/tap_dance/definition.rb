require 'tap_dance/brew'
require 'tap_dance/tap'
require 'tap_dance/ui'
require 'tap_dance'

module TapDance
  class Definition
    attr_accessor :taps
    attr_accessor :brews

    def initialize(taps=[], brews=[])
      @taps = taps
      @brews = brews
    end

    def add(type, *args)
      args.last[:definition] = self if args.last.is_a?(Hash)

      case type
      when :tap
        @taps << Tap.new(*args)
        @taps.last
      when :brew
        @brews << Brew.new(*args)
        @brews.last
      end
    end

    def tap_named(name)
      @taps.find { |t| t.name.to_s == name.to_s }
    end

    def execute(upgrade=false)
      for tap in @taps do
        TapDance.ui.confirm "Tapping \"#{tap}\""
        TapDance.ui.detail tap.entap
      end

      for brew in @brews do
        unless upgrade
          TapDance.ui.confirm "Installing \"#{brew}\""
          TapDance.ui.detail brew.install
        else
          TapDance.ui.confirm "Upgrading \"#{brew}\""
          TapDance.ui.detail brew.upgrade
        end
      end
    end
  end
end
