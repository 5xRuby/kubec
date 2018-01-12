module Kubec
  module Status
    # :nodoc:
    class Pod < Base
      fields %w[Name Ready Status Restarts Age]

      # :nodoc:
      class Item < Hash
        FIELDS = %i[name ready status restarts age].freeze

        attr_reader :spec, :metadata, :status, :containers

        def initialize(data)
          @data = data
          @metadata = data.dig('metadata')
          @spec = data.dig('spec')
          @status = data.dig('status')
          @containers = data.dig('status', 'containerStatuses')

          FIELDS.each { |field| send("setup_#{field}") }
        end

        protected

        def setup_name
          self['Name'] = metadata['name']
        end

        def setup_ready
          total = containers.size
          ready = containers.select do |item|
            item['state'].key?('running')
          end.size
          self['Ready'] = "#{ready}/#{total}"
        end

        def setup_status
          self['Status'] = status['phase']
        end

        def setup_restarts
          self['Restarts'] = containers.map do |c|
            c['restartCount'].to_i
          end.sum
        end

        def setup_age
          created_at = DateTime.parse(status['startTime']).to_time
          secs = (Time.now - created_at).ceil
          self['Age'] =
            Utils::HumanizeTime
            .humanize(secs, short: true, join: false).first
        end
      end
    end
  end
end
