module Kubec
  class Kubernetes
    # :nodoc:
    class Metadata < Hash
      def initialize(name)
        self[:name] = name
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
