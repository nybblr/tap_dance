require 'tap_dance/definition'
require 'tap_dance/brew'
require 'tap_dance/tap'
require 'tap_dance/ui'

class BrewfileError < RuntimeError; end
module TapDance
  class Dsl
    def self.evaluate(brewfile, lockfile=nil, unlock=nil)
      builder = new
      builder.eval_brewfile(brewfile)
      return @definition
    end

    def initialize
      @taps   = [] # All the taps found so far
      @brews  = [] # All the brews defined
      @groups = [] # Arg/filter groups
      @tap   = nil # Current tap scope

      @definition = Definition.new
    end

    def eval_brewfile(brewfile, contents = nil)
      contents ||= File.read File.expand_path(brewfile.to_s)
      instance_eval contents, brewfile.to_s, 1
    rescue SyntaxError => e
      bt = e.message.split("\n")[1..-1]
      raise BrewfileError, ["Brewfile syntax error:", *bt].join("\n")
    rescue ScriptError, RegexpError, NameError, ArgumentError => e
      e.backtrace[0] = "#{e.backtrace[0]}: #{e.message} (#{e.class})"
      TapDance.ui.warn e.backtrace.join("\n       ")
      raise BrewfileError, "There was an error in your Brewfile," \
        " and TapDance cannot continue."
    end

    ### DSL commands
    def tap(name, opts={})
      puts "Tapped \"#{name}\""
      @definition.tap name, opts
    end

    def brew(name, opts={})
      puts "Brewed \"#{name}\""
      @definition.brew name, opts
    end

  end
end
