require 'tap_dance/dsl'
require 'tap_dance/brew_cli'

describe TapDance::DSL do
  it "should run a simple Brewfile" do
    TapDance::BrewCLI.dry_run = true
    TapDance::DSL.evaluate "examples/01_brewfile.rb"
  end

  it "should run a Brewfile with filters given in brew" do
    TapDance::BrewCLI.dry_run = true
    TapDance::DSL.evaluate "examples/02_brewfile.rb"
  end
end
