require 'rake'
require 'json'
require 'forwardable'
require 'pathname'
require 'singleton'

require 'kubec/version'

# Kuberentes Config Tool
module Kubec
  autoload :Application, 'kubec/application'
  autoload :Environment, 'kubec/environment'
  autoload :Kubernetes, 'kubec/kubernetes'
  autoload :DSL, 'kubec/dsl'
end
