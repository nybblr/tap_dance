TapDance: Homebrew meets Bundler
===============================

Homebrew rocks, but managing system level dependencies can become a pain to track across multiple machines. Bundler was designed to make explicit declaration of Ruby dependencies consistent and painless. TapDance aims to do the same for system binaries by alleviating such issues as:
- "What did I `brew install` to make my vim plugins work?"
- "With what extra arguments did I run my python installation?"
- "Did I install that item in `brew list` for a reason I don't remember, or is it an automatically installed dependency?"
- "Ugh, I just want to pull my latest dotfiles and have everything work."

Installation
------------

The "best" way to install tap dance is by including it in your system-wide Gemfile (e.g. a Gemfile in your dotfiles).

Add this line to your application's Gemfile:

    gem 'tap_dance'

And then execute:

    $ bundle

If you don't version-control your dots, install it yourself as:

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

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
