# frozen_string_literal: true

module Kubec
  # Kubernetes
  class Kubernetes
    autoload :Config, 'kubec/kubernetes/config'
    autoload :Template, 'kubec/kubernetes/template'
    autoload :Service, 'kubec/kubernetes/service'
    autoload :Deployment, 'kubec/kubernetes/deployment'
    autoload :Metadata, 'kubec/kubernetes/metadata'
    autoload :Spec, 'kubec/kubernetes/spec'

    include Singleton

    APPLYABLE_TYPES = %i[service deployment].freeze

    class << self
      def apply(type)
        # TODO: Raise an error
        return unless APPLYABLE_TYPES.include?(type.to_sym)
        return debug(type) if Rake.application.options.debug
        # TODO: Replace with RESTful API
        IO.popen('kubectl apply -f -', 'r+') do |io|
          io.write convert_to_json(instance.send(type))
          io.close_write
          puts io.gets
        end
      end

      def debug(type)
        return unless APPLYABLE_TYPES.include?(type.to_sym)
        puts JSON.pretty_generate(instance.send(type))
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
    end

    def service(name = nil, &block)
      return @services if name.nil?
      @services << Kubernetes::Service.new(name, &block)
    end

    def deployment(name = nil, &block)
      return @deployments if name.nil?
      @deployments << Kubernetes::Deployment.new(name, &block)
    end
  end
end
