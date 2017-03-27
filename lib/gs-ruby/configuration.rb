# frozen_string_literal: true
require 'logger'

module GS
  # A configuration object used to define the path to the Ghostscript command,
  # any default options and the logger that should be used.
  class Configuration
    attr_writer :bin_path,
                :default_options,
                :logger

    # Gets the bin path to the Ghostscript command.
    #
    # * If no path has been set, it returns +'gs'+ as the default.
    #
    # @return [String] the path to the Ghostscript command
    def bin_path
      @bin_path ||= 'gs'
    end

    # Gets the default options.
    #
    # * If no default options have been set, it returns a set of options
    #   where +GS::BATCH+ is set by default.
    #
    # @return [Hash] the default options and their values
    def default_options
      @default_options ||= { GS::BATCH => nil }
    end

    # Gets the logger object.
    #
    # * If no logger has been set, it instantiates and returns a new logger
    #   configured to log to +$stdout+.
    #
    # @return [Logger] the logger instance used for logging
    def logger
      @logger ||= Logger.new($stdout).tap do |logger|
        logger.progname = bin_path
      end
    end
  end
end
