require 'rake'
require 'json'
require 'forwardable'
require 'pathname'
require 'singleton'
require 'hirb'
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
end
