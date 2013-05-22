require 'tap_dance/dsl'

describe TapDance::Dsl do
  it "should run a simple Brewfile" do
    TapDance::Dsl.evaluate "examples/01_brewfile.rb"
  end
end
