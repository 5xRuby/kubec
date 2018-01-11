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

extend Kubec::DSL
