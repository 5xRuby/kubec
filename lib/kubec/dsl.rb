require 'kubec/dsl/stages'
require 'kubec/dsl/paths'
require 'kubec/dsl/env'
require 'kubec/dsl/kubernetes'

module Kubec
  # DSL
  module DSL
    include Env
    include Paths
    include Stages
    include Kubernetes
  end
end
