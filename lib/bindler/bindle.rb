require 'bindler/brew'
require 'bindler/tap'

require 'thor'

module Bindler
	class Bindle < Thor
		package_name "Bindler"
		default_task "install"

		desc "install", "install all the brews in your Brewfile"
		def install
			return "hello world!"
		end

		desc "update", "update all the brews in your Brewfile"
		def update
			return "goodbye world!"
		end
	end
end
