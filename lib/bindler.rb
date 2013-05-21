require 'bindler/version'
require 'bindler/bindle'

module Bindler
	def self.respond_to?(method)
		Bindler.instance_methods.include? method
	end

	def self.method_missing(method, *args, &block)
		Bindler::Bindle.new.send(method, *args, &block)
	end
end
