# frozen_string_literal: true

module Kubec
  module DSL
    # :nodoc:
    module Kubernetes
      extend Forwardable

      def_delegators :kubernetes, :service, :deployment, :config, :cronjob

      def kubernetes
        Kubec::Kubernetes.instance
      end
    end
  end
end
