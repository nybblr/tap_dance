require 'bindler/brew'
require 'bindler/tap'

require 'thor'

module Bindler
	class Bindle < Thor
		package_name "Bindler"
		default_task "install"

		attr_accessor :brews
		attr_accessor :taps

		def initialize(*args, &block)
			super(*args, &block)
			@brews = []
			@taps = []
		end

		desc "install", "install all the brews in your Brewfile"
		def install
			unless command?(:brew)
				puts "You haven't installed homebrew, or it isn't in your path."
			end

			puts "hello"
		end

		desc "update", "update all the brews in your Brewfile"
		def update(name=nil)
			puts "goodbye"
			return "goodbye world!"
		end

	private

		# Note: susceptible to code injection!
		def command?(name)
			system "which #{name.to_s} > /dev/null 2>&1"
		end
	end
end
