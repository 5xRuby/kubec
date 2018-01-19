# frozen_string_literal: true

module Kubec
  class Kubernetes
    # :nodoc:
    class ConfigMap < Hash
      attr_reader :name, :files

      def initialize(name, &block)
        @name = name.to_sym
        @files = {}

        prepare
        instance_eval(&block)
      end

      # TODO: Refactor this feature
      def fetch(*args)
        Environment.instance.fetch(*args)
      end

      def set(key, value)
        self[:data][key] = value
      end

      # TODO: Refactor
      def file(path)
        key = path.split('/').last
        @files[key] = path
        path = path_with_stage(path) if stage_config_exist?(path)
        set key, File.read(path)
      end

      private

      def prepare
        self[:apiVersion] = 'v1'
        self[:metadata] = Metadata.new(@name)
        self[:kind] = 'ConfigMap'
        self[:data] = {}
      end

      def stage_config_exist?(path)
        File.exist?(path_with_stage(path))
      end

      def path_with_stage(path)
        path.split('.').tap do |ary|
          ext = ary.pop
          ary.push(fetch(:stage, :staging))
          ary.push(ext)
        end.join('.')
      end
    end
  end
end
