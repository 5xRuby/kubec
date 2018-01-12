module Kubec
  class Kubernetes
    # :nodoc:
    class Deployment < Config
      api_version 'extensions/v1beta1'

      def replicas(size)
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
