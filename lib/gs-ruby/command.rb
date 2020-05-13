# frozen_string_literal: true

require 'open3'

module GS
  # Command object for running a command with various options.
  #
  # * This is usually not instantiated directly, but rather by way of
  #   calling +GS.run+.
  class Command
    attr_reader :configuration,
                :options

    attr_accessor :logger

    # Initializes a new command instance.
    #
    # * If no configuration object is passed or is +nil+, the value of
    #   +GS.configuration+ is used as the configuration object
    #
    # * Any options passed are merged with +GS.configuration.default_options+
    #   so that any option can be deleted if necessary
    #
    # * If no logger object is passed or is +nil+, the value of
    #   +GS.configuration.logger+ is used as the logger object
    #
    # @param [Configuration] configuration the configuration object
    # @param [Hash] options the key-value pairs of command options
    # @param [Logger] logger the logger object
    def initialize(configuration: nil, options: {}, logger: nil)
      @configuration = configuration || GS.configuration
      @options = @configuration.default_options.merge(options)
      @logger = logger || @configuration.logger
    end

    # Sets a command option with an optional value.
    #
    # * If a value is passed, the resulting switch will be in the form
    #   +-sName=Value+. If no value is passed, the resulting switch will be
    #   in the form +-dName+.
    #
    # @param name [String] the name of the option
    # @param value [Object] the value of the option
    def option(name, value = nil)
      options[name] = value
    end

    # Executes the command with the specified input.
    #
    # @param [String] inputs the input arguments to the command
    #
    # @return [Process::Status] describing the result of running the command
    def run(inputs)
      command = "#{configuration.bin_path} #{build_switches} #{inputs}"

      status = nil
      logger.info(command)
      Open3.popen2e(command) do |_, stdout_and_stderr, wait_thr|
        logger.info(stdout_and_stderr.read)
        status = wait_thr.value
      end

      status
    end

    private

    def build_switches
      options.map do |(n, v)|
        flag   = '-d'
        option = n

        if v
          flag = '-s' if v.is_a?(String)

          option = "#{n}=#{v}"
        end

        "#{flag}#{option}"
      end.join(' ')
    end
  end
end
