module Kubec
  class Kubernetes
    # :nodoc:
    class Container < Hash
      include HasAttribute

      attribute :image
      attribute :name
      attribute :ports

      def initialize(name, &block)
        self[:name] = name
        instance_eval(&block)
      end

      def mount(name, at:)
        self[:volumeMounts] ||= []
        self[:volumeMounts].push name: name,
                                 mountPath: at
      end

      # TODO: Auto setup config map volume
      def config_file(name, path:, from:)
        self[:volumeMounts] ||= []
        self[:volumeMounts].push name: from,
                                 mountPath: [path, name].join('/'),
                                 subPath: name
      end

      # TODO: Add object to check fields
      def port(container_port, host_port = nil,
               ip: nil, name: nil, protocol: nil)
        self[:ports] ||= []
        port = {
          containerPort: container_port,
          hostPort: host_port,
          hostIP: ip,
          name: name,
          protocol: protocol
        }.compact
        self[:ports].push port
      end
    end
  end
end
