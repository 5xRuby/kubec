# frozen_string_literal: true

module Kubec
  class Kubernetes
    # :nodoc:
    class Volume < Hash
      def initialize(name, &block)
        self[:name] = name
        instance_eval(&block)
      end

      # TODO: Refactor this feature
      def fetch(*args)
        Environment.instance.fetch(*args)
      end

      def empty(memory = false)
        self[:emptyDir] = if memory
                            { medium: true }
                          else
                            {}
                          end
      end

      def host_path(path, type = nil)
        self[:hostPath] = { path: path }
        self[:hostPath][:type] = type unless type.nil?
      end

      def gce(name, type: 'ext4', ro: false)
        self[:gcePersistentDisk] = {
          pdName: name,
          fsType: type,
          readOnly: ro
        }
      end

      # TODO: Check for should create a new class to handle
      def config(name, items)
        self[:configMap] = {
          name: name,
          items: items.map do |key, path|
            { key: key, path: path }
          end
        }
      end

      def secret(name, items = nil)
        self[:secret] = {
          secretName: name,
          items: items&.map do |key, path|
            { key: key, path: path }
          end
        }.reject { |_, v| v.nil? }
      end
    end
  end
end
