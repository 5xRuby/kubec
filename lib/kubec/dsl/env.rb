# frozen_string_literal: true

module Kubec
  module DSL
    # ENV
    module Env
      extend Forwardable

      def_delegators :env, :fetch, :set

      def env
        Environment.instance
      end
    end
  end
end
