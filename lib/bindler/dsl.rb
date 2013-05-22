require 'bindler/definition'
require 'bindler/brew'
require 'bindler/tap'
require 'bindler/ui'

class BrewfileError < RuntimeError; end
module Bindler
  class Dsl
    def self.evaluate(brewfile, lockfile=nil, unlock=nil)
      builder = new
      builder.eval_brewfile(brewfile)
      builder.to_definition(lockfile, unlock)
    end

    def initialize
      @taps   = [] # All the taps found so far
      @brews  = [] # All the brews defined
      @groups = [] # Arg/filter groups
      @tap   = nil # Current tap scope
    end

    def eval_brewfile(brewfile, contents = nil)
      contents ||= File.read File.expand_path(brewfile.to_s)
      instance_eval contents, brewfile.to_s, 1
    rescue SyntaxError => e
      bt = e.message.split("\n")[1..-1]
      raise BrewfileError, ["Brewfile syntax error:", *bt].join("\n")
    rescue ScriptError, RegexpError, NameError, ArgumentError => e
      e.backtrace[0] = "#{e.backtrace[0]}: #{e.message} (#{e.class})"
      Bindler.ui.warn e.backtrace.join("\n       ")
      raise BrewfileError, "There was an error in your Brewfile," \
        " and Bindler cannot continue."
    end

    def to_definition(lockfile, unlock)
      return Definition.new(@taps, @brews)
    end

    def hello
      puts "HELLO WORLD!!!!!!!"
    end

  end
end
