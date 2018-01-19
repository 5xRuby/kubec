# frozen_string_literal: true

module Kubec
  class Kubernetes
    # :nodoc:
    class Deployment < Config
      api_version 'extensions/v1beta1'

      def replicas(size = nil)
        return spec[:replicas] || 1 if size.nil?
        spec[:replicas] = size.to_i
      end

      def template(&block)
        spec[:template] ||= Template.new
        spec[:template].instance_eval(&block)
      end

      # TODO: Move into module
      def select(key, value)
        spec[:selector] ||= { matchLabels: {} }
        spec[:selector][:matchLabels][key] = value
      end

      def selector=(labels)
        # TODO: Check labels type
        spec[:selector] = labels
      end

      alias selector selector=
    end
  end
end
