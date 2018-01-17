module Kubec
  class Kubernetes
    # :nodoc:
    class CronJob < Config
      api_version 'batch/v1beta1'

      def schedule(at)
        spec[:schedule] = at
      end

      def template(&block)
        inst = Template.new
        spec[:jobTemplate] = {
          spec: {
            template: inst
          }
        }
        inst.instance_eval(&block)
      end
    end
  end
end
