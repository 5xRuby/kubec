# frozen_string_literal: true

module Kubec
  class Kubernetes
    # :nodoc:
    class Service < Config
      api_version 'v1'

      def node_port
        spec[:type] = 'NodePort'
      end

      def load_balancer(ip: nil)
        spec[:type] = 'LoadBalancer'
        spec[:loadBalancerIP] = ip unless ip.nil?
      end

      def port(port, target = nil)
        spec[:ports] ||= []
        target ||= port
        spec[:ports].push port: port, targetPort: target
      end

      def select(key, value)
        spec[:selector] ||= {}
        spec[:selector][key] = value
      end

      def selector=(labels)
        # TODO: Check labels type
        spec[:selector] = labels
      end

      alias selector selector=
    end
  end
end
