require 'bindler/dsl'

describe Bindler::Dsl do
  it "should run a simple Brewfile" do
    Bindler::Dsl.evaluate "examples/01_brewfile.rb"
  end
end
