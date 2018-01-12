module Kubec
  module Status
    # :nodoc:
    class Deployment < Base
      fields ['Name', 'Desire', 'Current', 'Up to date', 'Available', 'Age']

      # :nodoc:
      class Item < Hash
        FIELDS = %i[name desire current up_to_date available age].freeze

        attr_reader :spec, :metadata, :status

        def initialize(data)
          @data = data
          @metadata = data.dig('metadata')
          @spec = data.dig('spec')
          @status = data.dig('status')

          FIELDS.each { |field| send("setup_#{field}") }
        end

        protected

        def setup_name
          self['Name'] = metadata['name']
        end

        def setup_desire
          self['Desire'] = spec['replicas'] || 1
        end

        def setup_current
          self['Current'] = status['readyReplicas'] || 0
        end

        def setup_up_to_date
          self['Up to date'] = status['updatedReplicas'] || 0
        end

        def setup_available
          self['Available'] = status['availableReplicas'] || 0
        end

        def setup_age
          # TODO: Human readable time
        end
      end
    end
  end
end
