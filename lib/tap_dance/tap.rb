module TapDance
  class Tap
    attr_accessor :name
    attr_accessor :url

    def initialize(name, url, opts={})
      @name = name.to_sym
      @url  = url.to_s
      @opts = opts
    end
  end
end
