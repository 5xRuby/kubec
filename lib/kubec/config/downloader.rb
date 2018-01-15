module Kubec
  module Config
    # :nodoc:
    class Downloader
      def initialize
        @result = `kubectl -n #{fetch(:stage, :staging)} get configmap -o json`
        @success = $CHILD_STATUS.success?
        @items = {}

        prepare
      end

      def save
        Kubernetes.config.each do |config|
          downloaded = @items[config.name]
          config.files.each do |(key, path)|
            write path, downloaded.dig('data', key)
          end
        end
      end

      private

      def prepare
        return unless @success
        items = JSON.parse(@result).dig('items') || []
        items.each do |item|
          name = item.dig('metadata', 'name').to_sym
          @items[name] = item
        end
      end

      def write(path, body)
        puts "=> #{path} saved"
        File.write(
          path_with_stage(path),
          body
        )
      end

      # TODO: Refactor
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
