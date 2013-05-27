require 'open3'

module TapDance
  class ShellResult
    attr_reader :out
    attr_reader :err
    attr_reader :status

    def self.of(cmd)
      out, err, sts = Open3.capture3 cmd
      new out, err, sts.exitstatus
    end

    def initialize(out, err=nil, status=0)
      @out    = out.to_s
      @err    = err.to_s
      @status = status
    end

    def okay?
      !error?
    end

    def error?
      @status != 0 || erred(@out) || erred(@err)
    end

    def stdout?
      @out.strip != ""
    end

    def stderr?
      @err.strip != ""
    end

    def to_s
      if @out.strip == "" then @err else @out end
    end

    ### We likes, but disable for refactoring
    # def method_missing(method, *args, &block)
    #   # Let people treat it like a string
    #   if String.new.respond_to? method
    #     to_s.send(method, *args, &block)
    #   else
    #     super
    #   end
    # end

    # def respond_to_missing?(method, include_private = false)
    #   String.new.respond_to?(method) || super
    # end

  private

    def erred(string)
      string[0..4] == 'Error'
    end

  end
end
