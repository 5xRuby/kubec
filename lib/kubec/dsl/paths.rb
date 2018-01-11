module Kubec
  module DSL
    # :nodoc:
    module Paths
      def stage_config_path
        Pathname.new 'config/kubec'
      end

      def stack_config_path
        Pathname.new 'config/kubec.rb'
      end
    end
  end
end

# rubocop:disable Style/MixinUsage
extend Kubec::DSL
# rubocop:enable Style/MixinUsage
