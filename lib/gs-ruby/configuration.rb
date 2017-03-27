# frozen_string_literal: true
require 'logger'

module GS
  # A configuration object used to define the path to the Ghostscript command,
  # any default options and the logger that should be used.
  #
  # * This is usually not instantiated directly, but rather by way of
  #   calling +GS.configure+.
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
    # @example Configuring a default option that requires a value
    #   GS.configure do |config|
    #     # Results in the switch -sProcessColorModel=DeviceCMYK
    #     config.default_options[GS::PROCESS_COLOR_MODEL] = 'DeviceCMYK'
    #   end
    #
    # @example Configuring a default option that does not require a value
    #   GS.configure do |config|
    #     # Results in the switch -dNOPAUSE
    #     config.default_options[GS::NO_PAUSE] = nil
    #   end
    #
    # @example Removing a default option that already exists
    #   GS.configure do |config|
    #     # Currently, GS::BATCH is the only option configured by default.
    #     # Not sure why you might want to remove it, but if you do, simply
    #     # delete it from the options Hash - same goes for any other option.
    #     config.default_options.delete(GS::BATCH)
    #   end
    #
    # @return [Hash] the default options and their values
    #
    # @see Command#option
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
