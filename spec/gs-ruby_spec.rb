# frozen_string_literal: true
require 'spec_helper'

describe GS do
  it 'has a version number' do
    expect(GS::VERSION).not_to be nil
  end

  describe '.configuration' do
    it 'returns a configuration object' do
      expect(GS.configuration).to be_a(GS::Configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration object' do
      expect { |b| GS.configure(&b) }.to yield_with_args(GS.configuration)
    end
  end

  describe '.run' do
    let(:command) { double(run: nil) }
    let(:inputs) { 'input.ps' }

    before { allow(GS::Command).to receive(:new).and_return(command) }

    it 'instantiates a new command with any options' do
      expect(GS::Command).to receive(:new).with(options: {})

      GS.run(inputs)
    end

    it 'yields the new command object' do
      expect { |b| GS.run(inputs, &b) }.to yield_with_args(command)
    end

    it 'runs the command with the specified input' do
      expect(command).to receive(:run).with(inputs)

      GS.run(inputs)
    end
  end
end
