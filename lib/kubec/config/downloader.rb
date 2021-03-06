# frozen_string_literal: true

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
          Utils::Path.with_stage(path),
          body
        )
      end
    end
  end
end
