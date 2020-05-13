# frozen_string_literal: true

require 'spec_helper'

describe GS::Command do
  subject(:command) { described_class.new }

  describe '#initialize' do
    context 'when no arguments are present' do
      it 'uses the global configuration object' do
        expect(command.configuration).to be(GS.configuration)
      end

      it 'uses the globally configured logger object' do
        expect(command.logger).to be(GS.configuration.logger)
      end

      it 'uses the globally configured default options' do
        expect(command.options).to eql(GS.configuration.default_options)
      end
    end
  end

  describe '#option' do
    context 'when a value is present' do
      let(:value) { 'DeviceCMYK' }

      before { command.option(GS::PROCESS_COLOR_MODEL, value) }

      it 'sets the option with the value' do
        expect(command.options).to include(GS::PROCESS_COLOR_MODEL => value)
      end
    end

    context 'when no value is present' do
      before { command.option(GS::NO_PAUSE) }

      it 'sets the option with no value' do
        expect(command.options).to include(GS::NO_PAUSE => nil)
      end
    end
  end

  describe '#run' do
    subject(:command) { described_class.new(logger: logger) }

    let(:stream) { double(read: output) }
    let(:output) { 'mock-output' }
    let(:thread) { double(value: status) }
    let(:status) { double }
    let(:logger) { double(info: nil) }
    let(:inputs) { 'input.ps' }

    before { allow(Open3).to receive(:popen2e).and_yield(nil, stream, thread) }

    it 'builds and executes the command correctly' do
      expected = "#{command.configuration.bin_path} -d#{GS::BATCH} #{inputs}"
      expect(Open3).to receive(:popen2e).with(expected)

      command.run(inputs)
    end

    it 'logs the output to the logger correctly' do
      expect(logger).to receive(:info).with(output)

      command.run(inputs)
    end

    it 'returns the resulting process status' do
      expect(command.run(inputs)).to be(status)
    end
  end

  describe '#build_switches' do
    let(:build_switches_call) do
      command.send(:build_switches)
    end

    context 'when the value is not present' do
      before do
        command.option(GS::NO_PAUSE)
      end

      it 'uses -d without a value' do
        expect(build_switches_call).to eq('-dBATCH -dNOPAUSE')
      end
    end

    context 'when the value is a string' do
      before do
        command.option(GS::PROCESS_COLOR_MODEL, 'DeviceCMYK')
      end

      it 'uses -s with a value' do
        expect(build_switches_call).to eq('-dBATCH -sProcessColorModel=DeviceCMYK')
      end
    end

    context 'when the value is not a string' do
      before do
        command.option(GS::PDFA_COMPATIBILITY_POLICY, 1)
      end

      it 'uses -d with a value' do
        expect(build_switches_call).to eq('-dBATCH -dPDFACompatibilityPolicy=1')
      end
    end
  end
end
