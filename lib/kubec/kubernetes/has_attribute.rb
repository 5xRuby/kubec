module Kubec
  class Kubernetes
    # :nodoc:
    module HasAttribute
      def self.included(base)
        base.extend ClassMethods
      end

      # :nodoc:
      module ClassMethods
        def attribute(name)
          name = name.to_sym
          define_method(name) do |value|
            return self[name] if value.nil?
            self[name] = value
          end
          define_method("#{name}=") { |value| self[name] = value }
        end
      end
    end
  end
end
