module Kubec
  # Kubec Application
  class Application < Rake::Application
    DEFAULT_KUBECFILES = [
      'Kubeconfig',
      'kubeconfig',
      'Kubeconfig.rb',
      'kubeconfig.rb'
    ].freeze

    def initialize
      super
      @rakefiles = DEFAULT_KUBECFILES.dup << default_kubeconfig
    end

    def name
      'kubec'
    end

    def run
      Rake.application = self
      super
    end

    def default_kubeconfig
      File.expand_path('../../Kubeconfig', __FILE__)
    end
  end
end
