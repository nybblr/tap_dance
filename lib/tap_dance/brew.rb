require 'tap_dance/ui'
require 'tap_dance/brew_cli'

module TapDance
  class Brew
    attr_accessor :name
    attr_accessor :tap

    def initialize(name, opts={})
      @opts  = opts.dup
      @name  = name.to_s
      @tap   = @opts[:tap]
      @flags = @opts[:flags] | []

      # Get actual tap object
      unless @tap.nil?
        case @tap
        when String, Symbol
          @tap = @opts[:definition].tap_named @tap.to_s
        when TapDance::Tap
          # Good to go!
        end
        @opts[:tap] = @tap
      end

    end

    def install
      if brewable?
        # Do magic here
      else
        TapDance.ui.error "No available formula for \"#{@name}\""
      end
    end

    def upgrade
      if installed?
        # Do magic here
      else
        TapDance.ui.error "You haven't installed \"#{@name}\""
      end
    end

    # Does the formula exist?
    def brewable?
      BrewCLI.formula_info(@name)[0..4] != 'Error'
    end

    def formula_version
      return nil unless brewable?
      BrewCLI.formula_info(@name).split($/).first.match(/#{name}: stable ([^\s,]+)/)[1]
    end

    def installed_versions
      # Would love to use StringScanner...but we don't need to!
      versions = BrewCLI.list_versions(@name).chomp.split(/\s+/)
      unless versions.empty?
        return versions[1..-1]
      else
        return []
      end
    end

    # Is a version installed?
    def installed?
      !installed_versions.empty?
    end

    def latest_version
      # Works unless the versions have
      # strings in them, like alpha/beta
      installed_versions.sort.last if installed?
    end

    def to_s
      if @tap
        "#{@tap.url}/#{@name}"
      else
        name
      end
    end

  end
end
