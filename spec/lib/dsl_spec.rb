require 'tap_dance/dsl'

describe TapDance::DSL do
  it "should run a simple Brewfile" do
    TapDance::DSL.evaluate "examples/01_brewfile.rb"
  end
end
