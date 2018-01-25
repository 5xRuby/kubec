# frozen_string_literal: true

module Kubec
  class Kubernetes
    # :nodoc:
    class Secret < ConfigMap
      # TODO: Refactor this feature
      def fetch(*args)
        Environment.instance.fetch(*args)
      end

      def set(key, value)
        self[:data][key] = Base64.encode64(value).delete("\n")
      end

      # TODO: Refactor
      def file(path)
        key = path.split('/').last
        @files[key] = path
        path = Utils::Path.with_stage(path) if stage_config_exist?(path)
        value = File.read(path) if File.exist?(path)
        set key, value || ''
      end

      private

      def prepare
        self[:apiVersion] = 'v1'
        self[:metadata] = Metadata.new(@name)
        self[:type] = 'Opaque'
        self[:kind] = 'Secret'
        self[:data] = {}
      end

      def stage_config_exist?(path)
        File.exist?(Utils::Path.with_stage(path))
      end
    end
  end
end
