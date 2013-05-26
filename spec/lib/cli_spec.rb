require 'tap_dance/cli'

describe TapDance::CLI do
  it "outputs hello when installing" do
    # TapDance::Dance.new.install.should eql("hello world!")
    # TapDance::CLI.new.install
  end

  it "outputs goodbye when updating" do
    # TapDance::Dance.new.update.should eql("goodbye world!")
    # TapDance::CLI.new.update
  end

  it "should be able to install with Brewfile including flags" do
    TapDance.ui = TapDance::UI::Shell.new
    TapDance::BrewCLI.dry_run = true

    cli = TapDance::CLI.new [], ["--brewfile", File.join(Dir.pwd, "examples/01_brewfile.rb")]
    cli.install
    # TapDance.ui.log.should include("Would run: brew install git")
  end
end

