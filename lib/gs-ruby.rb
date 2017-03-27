# frozen_string_literal: true
require 'gs-ruby/configuration'
require 'gs-ruby/options'
require 'gs-ruby/version'

# GS Ruby is a simple wrapper for the Ghostscript command - it's assumed
# that you have the +gs+ command already installed.
module GS
  include Options
end
