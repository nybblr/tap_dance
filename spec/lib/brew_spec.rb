require 'tap_dance/brew'
require 'tap_dance/tap'
require 'tap_dance/brew_cli'

describe TapDance::Brew do
  it "should let me create a brew without options" do
    brew = TapDance::Brew.new(:git)
    brew.should_not be_nil
  end

  it "should let me create a brew with options" do
    tap  = TapDance::Tap.new(:dev, "nybblr/dev")
    brew = TapDance::Brew.new(:git, :tap => tap)
    brew.should_not be_nil
    brew.tap.should eql(tap)
  end

  it "should say git is a brewable formula" do
    brew = TapDance::Brew.new(:git)
    brew.brewable?.should be_true
  end

  it "should say asdfgh is not a brewable formula" do
    brew = TapDance::Brew.new(:asdfgh)
    brew.brewable?.should be_false
  end

  it "should be able to parse out correct installed versions" do
    brew = TapDance::Brew.new(:git)
    TapDance::BrewCLI.stub :list_versions => "git 1.8.2.1 1.8.2.2 2.0.0.alpha"

    brew.installed_versions.should eql(%w[1.8.2.1 1.8.2.2 2.0.0.alpha])
  end

  it "should return nil if the brew isn't installed" do
    brew = TapDance::Brew.new(:asdfgh)

    brew.latest_version.should be_nil
  end

  it "should return the latest if the brew is installed" do
    brew = TapDance::Brew.new(:asdfgh)
    TapDance::BrewCLI.stub :list_versions => "git 1.8.2.1 1.8.2.2 2.0.0.alpha"

    brew.latest_version.should eql("2.0.0.alpha")
  end

  it "should say a brew isn't installed when it isn't" do
    brew = TapDance::Brew.new(:asdfgh)

    brew.installed?.should be_false
  end

  it "should say a brew is installed when it is" do
    brew = TapDance::Brew.new(:git)
    TapDance::BrewCLI.stub :list_versions => "git 1.8.2.1 1.8.2.2 2.0.0.alpha"

    brew.installed?.should be_true
  end

  it "should get any formula version if it exists" do
    brew = TapDance::Brew.new(:git)

    version = brew.formula_version
    version.should_not be_nil
    version.strip.should_not eql("")
  end

  it "should get the correct formula version when it exists" do
    TapDance::BrewCLI.stub :formula_info => <<-eos
git: stable 1.8.2.3, HEAD
http://git-scm.com
/usr/local/Cellar/git/1.8.2.1 (1289 files, 27M)
  Built from source
/usr/local/Cellar/git/1.8.2.2 (1290 files, 27M) *
  Built from source
https://github.com/mxcl/homebrew/commits/master/Library/Formula/git.rb
==> Dependencies
Optional: pcre, gettext
==> Options
--with-blk-sha1
        Compile with the block-optimized SHA1 implementation
--with-gettext
        Build with gettext support
--with-pcre
        Build with pcre support
--without-completions
        Disable bash/zsh completions from "contrib" directory
==> Caveats
The OS X keychain credential helper has been installed to:
  /usr/local/bin/git-credential-osxkeychain

The 'contrib' directory has been installed to:
  /usr/local/share/git-core/contrib

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completion has been installed to:
  /usr/local/share/zsh/site-functions"
    eos

    brew = TapDance::Brew.new(:git)
    brew.formula_version.should eql("1.8.2.3")
  end

  it "should return nil when no formula version exists" do
    brew = TapDance::Brew.new(:asdfgh)

    brew.formula_version.should be_nil
  end
end
