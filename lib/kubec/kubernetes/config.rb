module Kubec
  class Kubernetes
    # :nodoc:
    class Config < Hash
      attr_reader :name

      class << self
        def api_version(version = nil)
          return @api_version if version.nil?
          @api_version = version
        end

        def kind
          name.split('::').last
        end
      end

      def initialize(name, &block)
        @name = name.to_sym
        prepare
        instance_eval(&block)
      end

      def spec
        self[:spec]
      end

      def metadata(&block)
        self[:metadata].instance_eval(&block)
      end

      def prepare
        self[:apiVersion] = self.class.api_version
        self[:kind] = self.class.kind
        self[:metadata] = Metadata.new(@name)
        self[:spec] = {}
      end
    end
  end
end