require 'tap_dance/brew_cli'
require 'tap_dance/ui'
require 'tap_dance'
require 'thor'

describe TapDance::BrewCLI do
  it "should be able to do a dry-run on volatile actions" do
    TapDance.ui = TapDance::UI::Logger.new
    TapDance::BrewCLI.dry_run = true
    TapDance::BrewCLI.install "git"
    TapDance.ui.log.should include("Would run: brew install git")
  end
end
