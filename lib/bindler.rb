require 'bindler/version'
require 'bindler/bindle'
require 'bindler/ui'

module Bindler
  def self.respond_to?(method)
    Bindler.instance_methods.include? method
  end

  def self.method_missing(method, *args, &block)
    Bindler::Bindle.new.send(method, *args, &block)
  end

  class << self
    attr_writer :ui

    def ui
      @ui ||= UI.new
    end
  end
end
