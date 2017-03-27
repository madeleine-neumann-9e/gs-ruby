# frozen_string_literal: true
require 'gs-ruby/configuration'
require 'gs-ruby/options'
require 'gs-ruby/version'

# GS Ruby is a simple wrapper for the Ghostscript command - it's assumed
# that you have the +gs+ command already installed.
#
# == Configuration
#
# Global configuration is possible:
#
#    GS.configure do |config|
#      config.bin_path = '/path/to/gs'
#    end
#
# @see GS.configure
module GS
  include Options

  module_function

  # Gets the configuration object.
  #
  # If none was set, a new configuration object is instantiated and returned.
  #
  # @return [Configuration] the configuration object
  def configuration
    @configuration ||= Configuration.new
  end

  # Allows for configuring the library using a block.
  #
  # @example Configuration using a block
  #   GS.configure do |config|
  #     # ...
  #   end
  def configure
    yield(configuration) if block_given?
  end
end
