# frozen_string_literal: true

module Kubec
  module Utils
    # :nodoc:
    module Path
      class << self
        def dotfile?(path)
          path
            .split('/')
            .last
            .split('.')
            .first
            .empty?
        end

        def with_stage(path)
          path.split('.').tap do |ary|
            ext = ary.pop unless dotfile?(path)
            ary.push(fetch(:stage, :staging))
            ary.push(ext) if ext
          end.join('.')
        end
      end
    end
  end
end
