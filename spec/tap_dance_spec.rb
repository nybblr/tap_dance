require 'tap_dance'

describe TapDance do
  it "shouldn't mind aliasing to the module" do
    TapDance.install.should eql(TapDance::CLI.new.install)
    TapDance.update.should eql(TapDance::CLI.new.update)
  end
end

