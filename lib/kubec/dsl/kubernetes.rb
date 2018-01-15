# frozen_string_literal: true

module Kubec
  module DSL
    # :nodoc:
    module Kubernetes
      extend Forwardable

      def_delegators :kubernetes, :service, :deployment, :config

      def kubernetes
        Kubec::Kubernetes.instance
      end
    end
  end
end
