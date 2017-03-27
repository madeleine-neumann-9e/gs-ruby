# frozen_string_literal: true
require 'gs-ruby/command'
require 'gs-ruby/configuration'
require 'gs-ruby/options'
require 'gs-ruby/version'

# GS Ruby is a simple wrapper for the Ghostscript command - it's assumed
# that you have the +gs+ command already installed.
#
# == Usage
#
# Typical usage might look like:
#
#    GS.run('input.ps', GS::OUTPUT_FILE => 'output.pdf')
#
# Or using a block to work with the command before it's run:
#
#    GS.run('input.ps') do |command|
#      command.option(GS::OUTPUT_FILE, 'output.pdf')
#    end
#
# == Configuration
#
# Global configuration is possible:
#
#    GS.configure do |config|
#      config.bin_path = '/path/to/gs'
#    end
#
# == Logging
#
# By default all output is logged to +$stdout+, but the logger can be
# configured:
#
#    # For a single command instance.
#    GS.run('input.ps') do |command|
#      command.logger = # ...
#    end
#
#    # For all command instances.
#    GS.configure do |config|
#      config.logger = # ...
#    end
#
# @see GS.run
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

  # Instantiates a new command object with any provided options and runs it
  # with the provided input.
  #
  # @example Run a new command with options
  #   GS.run('input.ps', GS::OUTPUT_FILE => 'output.pdf')
  #
  # @example Configure and run a new command
  #   GS.run('path/to/input/file.ps') do |command|
  #     command.option(GS::OUTPUT_FILE, 'output.pdf')
  #   end
  #
  # @return [Process::Status] describing the result of running the command
  #
  # @see Command#option
  # @see Command#run
  def run(input, options = {})
    command = Command.new(options: options)
    yield(command) if block_given?
    command.run(input)
  end
end
