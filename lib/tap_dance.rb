require 'tap_dance/version'
require 'tap_dance/cli'
require 'tap_dance/ui'

module TapDance
  def self.respond_to?(method)
    TapDance.instance_methods.include? method
  end

  def self.method_missing(method, *args, &block)
    TapDance::CLI.new.send(method, *args, &block)
  end

  class << self
    attr_writer :ui

    def ui
      @ui ||= UI::Logger.new
    end
  end
end
