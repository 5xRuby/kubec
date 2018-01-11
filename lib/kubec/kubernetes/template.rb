module Kubec
  class Kubernetes
    # :nodoc:
    class Template < Hash
      def initialize
        self[:metadata] = Metadata.new
        self[:spec] = {}
      end

      def metadata(&block)
        self[:metadata].instance_eval(&block)
      end

      def spec
        self[:spec]
      end

      def container(options = {})
        # TODO: Generate by container builder
        spec[:containers] ||= []
        spec[:containers].push options
      end
    end
  end
end
