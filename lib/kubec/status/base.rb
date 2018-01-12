module Kubec
  # :nodoc:
  module Status
    autoload :Printer,    'kubec/status/printer'
    autoload :Service,    'kubec/status/service'
    autoload :Deployment, 'kubec/status/deployment'
    autoload :Pod,        'kubec/status/pod'

    # :nodoc:
    class Base
      include Enumerable

      class << self
        def fields(fields = nil)
          return @fields if fields.nil?
          @fields = fields
        end

        def print
          if fields.nil?
            ptus Hirb::Helpers::AutoTable.render(new)
          else
            puts Hirb::Helpers::AutoTable.render(new, fields: fields)
          end
        end
      end

      def initialize
        @type = self.class.name.split('::').last.downcase
        @result = `kubectl -n #{fetch(:stage, :staging)} get #{@type} -o json`
        @success = $CHILD_STATUS.success?
        @items = []

        prepare
      end

      def each(&_block)
        return unless @success
        @items.each do |item|
          yield self.class.const_get('Item').new(item)
        end
      end

      private

      def prepare
        return unless @success
        @items = JSON.parse(@result).dig('items') || []
      end
    end
  end
end
