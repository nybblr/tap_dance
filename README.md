[![Gem Version](https://badge.fury.io/rb/tap_dance.png)](http://badge.fury.io/rb/tap_dance)
[![Dependency Status](https://gemnasium.com/nybblr/tap_dance.png)](https://gemnasium.com/nybblr/tap_dance)
[![Code Climate](https://codeclimate.com/github/nybblr/tap_dance.png)](https://codeclimate.com/github/nybblr/tap_dance)
[![Coverage Status](https://coveralls.io/repos/nybblr/tap_dance/badge.png?branch=master)](https://coveralls.io/r/nybblr/tap_dance)

Tap Dance: Homebrew meets Bundler
===============================

Homebrew rocks, but managing system level dependencies can become a pain to track across multiple machines. Bundler was designed to make explicit declaration of Ruby dependencies consistent and painless. Tap Dance aims to do the same for system binaries by alleviating such issues as:
- "What did I `brew install` to make my vim plugins work?"
- "With what extra arguments did I run my python installation?"
- "Did I install that item in `brew list` for a reason I don't remember, or is it an automatically installed dependency?"
- "Ugh, I just want to pull my latest dotfiles and have everything work."

Installation
------------

The "best" way to install tap dance is by including it in your system-wide Gemfile (e.g. a Gemfile in your dotfiles).

Add this line to your Gemfile:

    gem 'tap_dance'

And then execute:

    $ bundle

If you don't version-control your dots (which you should), install it yourself as:

    $ gem install tap_dance

Usage
-----

TODO: Write usage instructions here

What's up with the name?
------------------------

Because declaring system and project deps with an awesome ruby gem makes me want to dance. Although I actually prefer swing and waltz.

Features
--------

Limit by:
- matching computer name
- environment variable
- shell script
- if installed

Groups

Credit where due!
-----------------

Huge thanks to Yehuda Katz for his awesome work on Bundler. I shamelessly stole a lot of the feature ideas and Gemfile evaluation magic from it. Oh, and obviously since the gem is built around Homebrew, a big thanks to Max and the community around brew: it has redefined my machine setup workflow.

Contributing
------------

I love contributions: give me a hand by including an in-depth description of the problem fixed or feature implemented, with usage information if applicable.

Most importantly, please include tests: if the request fixes a bug, include one or more failing tests which cover the issue. For new features, try to cover the basic functionalities, making sure the tests can pass on any properly configured OSX workstation.

**Steps to contribution awesomeness:**

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Although you could just make your commits on the master branch, it's easier to inspect merge histories with actual feature branches. It also makes the bounds of your contribution obvious. Did I mention it looks better in `git log --oneline --graph`
