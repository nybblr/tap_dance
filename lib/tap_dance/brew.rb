require 'tap_dance/ui'
require 'tap_dance/brew_cli'

module TapDance
  class Brew
    attr_accessor :name
    attr_accessor :version
    attr_accessor :tap
    attr_accessor :filters

    def initialize(name, version=nil, opts={})
      @opts    = opts.dup
      @name    = name.to_s
      @version = version
      @tap     = @opts[:tap]
      @flags   = @opts[:flags] || []
      @filters = @opts[:filters] || []

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
        BrewCLI.install canonical, @flags
      else
        TapDance.ui.error "No available formula for \"#{canonical}\""
      end
    end

    def upgrade
      if installed?
        # Do magic here
        BrewCLI.upgrade canonical, @flags
      else
        TapDance.ui.error "You haven't installed \"#{canonical}\""
      end
    end

    def canonical
      unless @tap.nil?
        "#{@tap.url}/#{@name}"
      else
        @name
      end
    end

    # Does the formula exist?
    def brewable?
      BrewCLI.formula_info(canonical).okay?
    end

    def formula_version
      res = BrewCLI.formula_info(canonical)
      return nil unless res.okay?

      res.out.split($/).first.match(/#{name}: stable ([^\s,]+)/)[1]
    end

    def formula_versions
      # Takes a long time to get; cache return
      if @formula_versions.nil?
        @formula_versions = BrewCLI.formula_versions(canonical).
          out.chomp.split($/).map do |v|
          s = v.split(/\s+/)
          version = s[0]
          commit  = s[3]
          path    = s[4]
          [ version, commit, path ]
        end
      else
        return @formula_versions
      end
    end

    def installed_versions
      # Would love to use StringScanner...but we don't need to!
      versions = BrewCLI.list_versions(canonical).out.strip.split(/\s+/)
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
      return canonical
    end

  end
end
