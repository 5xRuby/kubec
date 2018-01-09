# frozen_string_literal: true

module Kubec
  module DSL
    # Stage
    module Stages
      RESERVED_NAMES = %w[deploy install status logs].freeze

      def stages
        names = Dir[stage_definitions].map { |f| File.basename(f, '.rb') }
        assert_valid_stage_names(names)
        names
      end

      def stage_definitions
        stage_config_path.join('*.rb')
      end

      def stage_set?
        !fetch(:stage, nil).nil?
      end

      def assert_valid_stage_names(names)
        invalid = names.find { |n| RESERVED_NAMES.include?(n) }
        return if invalid.nil?

        # TODO: I18n Support
        raise "Invalid stage name #{invalid}.rb"
      end
    end
  end
end
