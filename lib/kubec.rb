# frozen_string_literal: true

require 'rake'
require 'json'
require 'forwardable'
require 'pathname'
require 'singleton'
require 'hirb'
require 'colorize'
require 'base64'
require 'English'

require 'kubec/version'

# Kuberentes Config Tool
module Kubec
  autoload :Application, 'kubec/application'
  autoload :Environment, 'kubec/environment'
  autoload :Kubernetes,  'kubec/kubernetes'
  autoload :DSL,         'kubec/dsl'
  autoload :Status,      'kubec/status/base'
  autoload :Utils,       'kubec/utils'
  # TODO: Replace with Downloader
  autoload :Config,      'kubec/config/base'
  autoload :Secret,      'kubec/secret/base'
end
