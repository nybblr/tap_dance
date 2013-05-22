require 'tap_dance/ui'

module TapDance
  class Brew
    attr_accessor :name
    attr_accessor :tap

    def initialize(name, opts={})
      @name = name.to_s
      @tap  = opts[:tap].to_sym if opts[:tap]
      @opts = opts
    end

    def install
      if brewable?
        # Do magic here
      else
        TapDance.ui.error "No available formula for #{@name}"
      end
    end

    # Does the formula exist?
    def brewable?
      cmd_formula_info[0..4] != 'Error'
    end

    def formula_version
      return nil unless brewable?
      cmd_formula_info.split($/).first.match(/#{name}: stable ([^\s,]+)/)[1]
    end

    def installed_versions
      # Would love to use StringScanner...but we don't need to!
      versions = cmd_list_versions.chomp.split(/\s+/)
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

  private

    ### These make it easier to test with stubbing
    def cmd_list_versions
      `brew list --versions #{@name}`
    end

    def cmd_formula_info
      `brew info #{@name} 2>&1`
    end

  end
end
