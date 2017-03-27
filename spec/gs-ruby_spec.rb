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
end
