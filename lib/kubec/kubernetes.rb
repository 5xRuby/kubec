# frozen_string_literal: true

module Kubec
  # Kubernetes
  class Kubernetes
    autoload :Config,     'kubec/kubernetes/config'
    autoload :ConfigMap,  'kubec/kubernetes/config_map'
    autoload :CronJob,    'kubec/kubernetes/cron_job'
    autoload :Template,   'kubec/kubernetes/template'
    autoload :Service,    'kubec/kubernetes/service'
    autoload :Deployment, 'kubec/kubernetes/deployment'
    autoload :Metadata,   'kubec/kubernetes/metadata'
    autoload :Spec,       'kubec/kubernetes/spec'
    autoload :Container,  'kubec/kubernetes/container'
    autoload :Volume,     'kubec/kubernetes/volume'

    autoload :HasAttribute, 'kubec/kubernetes/has_attribute'

    include Singleton

    APPLYABLE_TYPES = %i[service deployment config cronjob].freeze

    class << self
      def apply(type)
        # TODO: Raise an error
        return unless APPLYABLE_TYPES.include?(type.to_sym)
        return debug(type) if Rake.application.options.debug
        # TODO: Replace with RESTful API
        execute(type)
      end

      def cmd
        return 'kubectl apply --dry-run -f -' if Rake.application.options.dry
        'kubectl apply -f -'
      end

      def execute(type)
        IO.popen(cmd, 'r+') do |io|
          io.write convert_to_json(instance.send(type))
          io.close_write
          puts io.gets
        end
      end

      def debug(type)
        return unless APPLYABLE_TYPES.include?(type.to_sym)
        puts JSON.pretty_generate(instance.send(type))
      end

      def ensure_namespace
        return if Rake.application.options.debug
        stage = fetch(:stage, :staging)

        # TODO: Replace with RESTful API
        `kubectl get ns #{stage} 2>&1`
        `kubectl create ns #{stage}` unless $CHILD_STATUS.success?
      end

      def convert_to_json(items)
        {
          apiVersion: 'v1',
          items: items,
          kind: 'List'
        }.to_json
      end
    end

    def initialize
      @services = []
      @deployments = []
      @configs = []
      @cronjobs = []
    end

    def service(name = nil, &block)
      return @services if name.nil?
      @services << Kubernetes::Service.new(name, &block)
    end

    def deployment(name = nil, &block)
      return @deployments if name.nil?
      @deployments << Kubernetes::Deployment.new(name, &block)
    end

    def config(name = nil, &block)
      return @configs if name.nil?
      @configs << Kubernetes::ConfigMap.new(name, &block)
    end

    def cronjob(name = nil, &block)
      return @cronjobs if name.nil?
      @cronjobs << Kubernetes::CronJob.new(name, &block)
    end
  end
end
