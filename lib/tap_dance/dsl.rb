require 'tap_dance/definition'
require 'tap_dance/brew'
require 'tap_dance/tap'
require 'tap_dance/ui'

class BrewfileError < RuntimeError; end
module TapDance
  class DSL
    attr_reader :definition

    def self.evaluate(brewfile, lockfile=nil, unlock=nil)
      builder = new
      builder.eval_brewfile(brewfile)
      builder.definition
    end

    def initialize
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
    def tap(name, url, opts={})
      # Can't nest taps; doesn't make sense
      raise BrewfileError, "You cannot nest taps!" unless @tap.nil?
      old_tap = @tap

      @tap = @definition.tap name, url, opts

      yield if block_given?

      @tap = old_tap
    end

    def brew(name, opts={})
      @definition.brew name, { :tap => @tap }.merge(opts)
    end

  end
end
