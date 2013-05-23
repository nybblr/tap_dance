module TapDance
  class Tap
    attr_accessor :name
    attr_accessor :url

    def initialize(name, url, opts={})
      @name = name.to_sym
      @url  = url.to_s
      @opts = opts
    end

    def entap
      cmd_tap
    end

    def untap
      cmd_untap
    end

    def tapped?
      cmd_tap_list.each_line { |t|
        return true if @url == t.chomp
      }

      return false
    end

    def to_s
      "#{@name}:#{@url}"
    end

  private

    ### Easier to stub
    def cmd_tap
      `brew tap @{url} 2>&1`
    end

    def cmd_untap
      `brew untap @{url} 2>&1`
    end

    def cmd_tap_list
      `brew tap`
    end

  end
end
