require 'tap_dance/cli'

describe TapDance::CLI do
  it "outputs hello when installing" do
    # TapDance::Dance.new.install.should eql("hello world!")
    TapDance::CLI.new.install
  end

  it "outputs goodbye when updating" do
    # TapDance::Dance.new.update.should eql("goodbye world!")
    TapDance::CLI.new.update
  end
end

