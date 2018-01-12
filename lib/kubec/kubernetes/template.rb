module Kubec
  class Kubernetes
    # :nodoc:
    class Template < Hash
      extend Forwardable

      def_delegators :metadata, :labels, :label

      def initialize
        self[:metadata] = Metadata.new
        self[:spec] = {}
      end

      def metadata(&block)
        return self[:metadata] unless block_given?
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
