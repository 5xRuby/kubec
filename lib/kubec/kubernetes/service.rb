module Kubec
  class Kubernetes
    # :nodoc:
    class Service < Config
      api_version 'v1'

      def port(port, target = nil)
        spec[:ports] ||= []
        target ||= port
        spec[:ports].push port: port, targetPort: target
      end

      def selector(labels)
        # TODO: Check labels type
        spec[:selector] = labels
      end
    end
  end
end
