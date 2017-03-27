# frozen_string_literal: true
require 'spec_helper'

describe GS::Configuration do
  subject(:configuration) { described_class.new }

  describe '#bin_path' do
    let(:bin_path) { 'path-to-bin' }

    context 'when bin path has been set' do
      before { configuration.bin_path = bin_path }

      it 'returns the bin path that was set' do
        expect(configuration.bin_path).to eql(bin_path)
      end
    end

    context 'when no bin path has been set' do
      before { configuration.bin_path = nil }

      it 'returns the default bin path' do
        expect(configuration.bin_path).to eql('gs')
      end
    end
  end

  describe '#default_options' do
    let(:default_options) { { 'NO_PAUSE' => nil } }

    context 'when default options have been set' do
      before { configuration.default_options = default_options }

      it 'returns the options that were set' do
        expect(configuration.default_options).to eql(default_options)
      end
    end

    context 'when no default options have been set' do
      before { configuration.default_options = nil }

      it 'returns an empty set of options' do
        expect(configuration.default_options).to eql(GS::BATCH => nil)
      end
    end
  end

  describe '#logger' do
    let(:logger) { double('progname=' => nil) }

    context 'when a logger has been set' do
      before { configuration.logger = logger }

      it 'returns the logger that was set' do
        expect(configuration.logger).to eql(logger)
      end
    end

    context 'when no logger has been set' do
      before { allow(Logger).to receive(:new).and_return(logger) }

      it 'returns a new logger configured to write to STDOUT' do
        expect(Logger).to receive(:new).with($stdout)

        configuration.logger
      end

      it 'configures the logger to use the bin path as the prog name' do
        expect(logger).to receive(:progname=).with(configuration.bin_path)

        configuration.logger
      end
    end
  end
end
