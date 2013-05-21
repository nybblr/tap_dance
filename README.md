Bindler: Homebrew meets Bundler
===============================

Homebrew rock, but managing system level dependencies can become a pain to track across multiple machines. Bundler was invented to make explicit declaration of Ruby dependencies consistent and painless. Bindler aims to do the same for system binaries by alleviating such issues as:
- "What did I `brew install` to make my vim plugins work?"
- "What extra arguments did I run the installation with?"
- "Did I install that in `brew list` for a reason I don't remember, or is it a dependency?"
- "Ugh, I just want to pull my latest dotfiles and have everything work."

Installation
------------

The "best" way to install bindler is by including it in your system-wide Gemfile (e.g. a Gemfile in your dotfiles).

Add this line to your application's Gemfile:

    gem 'bindler'

And then execute:

    $ bundle

If you don't version-control your dots, install it yourself as:

    $ gem install bindler

Usage
-----

TODO: Write usage instructions here

What's up with the name?
------------------------
Bindler manages system binaries. Got it, right?

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
