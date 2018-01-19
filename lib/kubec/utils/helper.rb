# frozen_string_literal: true

module Kubec
  module Utils
    # :nodoc:
    module Helper
      class << self
        def header(title, color: :green)
          puts "=== #{title} ===".colorize(color)
        end
      end
    end
  end
end
