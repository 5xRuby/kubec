# frozen_string_literal: true

module Kubec
  module Status
    # :nodoc:
    class Service < Base
      fields ['Name', 'Cluster IP', 'Ports', 'Selector']

      # :nodoc:
      class Item < Hash
        FIELDS = %i[name cluster_ip ports selector].freeze

        attr_reader :spec, :metadata

        def initialize(data)
          @data = data
          @metadata = data.dig('metadata')
          @spec = data.dig('spec')

          FIELDS.each { |field| send("setup_#{field}") }
        end

        protected

        def setup_name
          self['Name'] = metadata['name']
        end

        def setup_cluster_ip
          self['Cluster IP'] = spec['clusterIP']
        end

        def setup_ports
          self['Ports'] = spec['ports'].map do |port|
            target = port['nodePort'] || port['targetPort']
            "#{port['port']}:#{target}/#{port['protocol']}"
          end.join(', ')
        end

        def setup_selector
          self['Selector'] =
            spec['selector']
            .map(&:to_a)
            .map { |pair| pair.join('=') }
            .join(', ')
        end
      end
    end
  end
end
