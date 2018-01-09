# frozen_string_literal: true

module Kubec
  # Environment
  class Environment < Hash
    include Singleton

    def fetch(key, default = nil)
      self[key.to_sym] || default
    end

    def set(key, value)
      self[key.to_sym] = value
    end
  end
end
