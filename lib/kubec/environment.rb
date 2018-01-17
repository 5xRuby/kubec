# frozen_string_literal: true

module Kubec
  # Environment
  class Environment < Hash
    include Singleton

    def set(key, value)
      self[key.to_sym] = value
    end
  end
end
