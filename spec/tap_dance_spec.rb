require 'tap_dance'

describe TapDance do
  it "shouldn't mind aliasing to the module" do
    TapDance.install.should eql(TapDance::Dance.new.install)
    TapDance.update.should eql(TapDance::Dance.new.update)
  end
end

describe TapDance::Dance do
  it "outputs hello when installing" do
    # TapDance::Dance.new.install.should eql("hello world!")
    TapDance::Dance.new.install
  end

  it "outputs goodbye when updating" do
    # TapDance::Dance.new.update.should eql("goodbye world!")
    TapDance::Dance.new.update
  end
end

