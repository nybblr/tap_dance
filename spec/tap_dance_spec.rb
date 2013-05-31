require 'tap_dance'

describe TapDance do
  it "shouldn't mind aliasing to the module" do
    # TapDance.install.should eql(TapDance::CLI.new.install)
    # TapDance.update.should eql(TapDance::CLI.new.update)
  end

  it "should use a default logger" do
    TapDance.ui.should_not be_nil
  end
end

