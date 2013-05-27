require 'tap_dance/brew_cli/result'

describe TapDance::BrewCLI::Result do
  it "should report error if the result is failure" do
    res = TapDance::BrewCLI::Result.new "Hello world!", "", 0

    res.error?.should be_false
    res.okay?.should  be_true
  end

  it "should report error even if nil is used" do
    res = TapDance::BrewCLI::Result.new "Hello world!", nil, 0

    res.error?.should be_false
    res.okay?.should  be_true
  end

  it "should use exit status as ultimatum" do
    res = TapDance::BrewCLI::Result.new "Hello world!", nil, 1

    res.error?.should be_true
    res.okay?.should  be_false

    res = TapDance::BrewCLI::Result.new "Hello world!", "Something...", 1

    res.error?.should be_true
    res.okay?.should  be_false
  end

  it "should notice standard output or error prefixed with Error" do
    res = TapDance::BrewCLI::Result.new "Error: something", nil, 0

    res.error?.should be_true
    res.okay?.should  be_false

    res = TapDance::BrewCLI::Result.new "Hello world!", "Error: hello", 0

    res.error?.should be_true
    res.okay?.should  be_false
  end

  it "should report stdout and stderr if it is not blank" do
    res = TapDance::BrewCLI::Result.new "Hello world!", "", 0

    res.stdout?.should be_true
    res.stderr?.should be_false

    res = TapDance::BrewCLI::Result.new "Hello world!", "That's bad.", 0

    res.stdout?.should be_true
    res.stderr?.should be_true
  end

  it "should make a pretty string using stdout if available" do
    res = TapDance::BrewCLI::Result.new "Hello world!", "", 0
    res.to_s.should eql("Hello world!")

    res = TapDance::BrewCLI::Result.new "Hello world!", "That's bad.", 0
    res.to_s.should eql("Hello world!")

    res = TapDance::BrewCLI::Result.new "", "That's bad.", 0
    res.to_s.should eql("That's bad.")
  end

  it "should correctly get exit status of command" do
    res = TapDance::BrewCLI::Result.of("echo hello && exit 1")
    res.status.should eql(1)
    res.out.chomp.should eql("hello")
    res.err.chomp.should eql("")
  end

  it "should correctly get stderr when included" do
    res = TapDance::BrewCLI::Result.of("echo hello >&2 && exit 0")
    res.status.should eql(0)
    res.out.chomp.should eql("")
    res.err.chomp.should eql("hello")
  end
end
