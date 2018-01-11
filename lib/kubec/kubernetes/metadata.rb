module Kubec
  class Kubernetes
    # :nodoc:
    class Metadata < Hash
      def initialize(name = nil)
        self[:name] = name unless name.nil?
        self[:namespace] = fetch(:stage, :staging)
      end

      def labels=(labels)
        # TODO: Check labels is valid
        self['labels'] = labels
      end

      alias labels labels=
    end
  end
end
