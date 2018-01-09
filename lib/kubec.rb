require 'rake'
require 'forwardable'
require 'pathname'
require 'singleton'

require 'kubec/version'

# Kuberentes Config Tool
module Kubec
  autoload :Application, 'kubec/application'
  autoload :Environment, 'kubec/environment'
  autoload :DSL, 'kubec/dsl'
end
