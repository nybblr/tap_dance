require 'tap_dance/tap'
require 'tap_dance/brew'

describe TapDance::Tap do
  it "should say it is tapped if it already is" do
    tap = TapDance::Tap.new(:dev, "nybblr/dev")
    tap.stub :cmd_tab_list => <<-eos
homebrew/dupes
homebrew/science
nybblr/dev
samueljohn/python
    eos

    tap.tapped?.should be_true
  end

  it "should say it isn't tapped if it isn't" do
    tap = TapDance::Tap.new(:dev, "nybblr/dev")
    tap.stub :cmd_tab_list => <<-eos
homebrew/dupes
homebrew/science
    eos

    tap.tapped?.should be_false
  end
end
