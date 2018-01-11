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
    end
  end
end
