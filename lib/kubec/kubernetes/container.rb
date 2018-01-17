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

      # TODO: Refactor this feature
      def fetch(*args)
        Environment.instance.fetch(*args)
      end

      def env(key, value)
        self[:env] ||= []
        self[:env].push name: key,
                        value: value.to_s
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
        }
        self[:ports].push port
      end

      def command(*args)
        args = args.flatten
        self[:command] = args.take(1)
        self[:args] = args.drop(1)
      end

      def args(*args)
        self[:args] = args.flatten
      end
    end
  end
end
