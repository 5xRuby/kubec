module Kubec
  class Kubernetes
    # :nodoc:
    class Metadata < Hash
      def initialize(name = nil)
        self[:name] = name unless name.nil?
        self[:namespace] = fetch(:stage, :staging)
      end

      # TODO: Refactor this feature
      def fetch(*args)
        Environment.instance.fetch(*args)
      end

      def label(key, value)
        self['labels'] ||= {}
        self['labels'][key] = value
      end

      def labels=(labels = nil)
        self['labels'] ||= {}
        return self['labels'] if labels.nil?
        # TODO: Check labels is valid
        self['labels'] = labels
      end

      alias labels labels=
    end
  end
end
