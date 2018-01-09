require 'kubec/dsl/stages'
require 'kubec/dsl/paths'
require 'kubec/dsl/env'

module Kubec
  # DSL
  module DSL
    include Env
    include Paths
    include Stages
  end
end
