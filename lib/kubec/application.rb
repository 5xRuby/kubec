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

    def handle_options
      options.rakelib = ['rakelib']
      options.trace_output = STDERR

      OptionParser.new do |opts|
        opts.on_tail('-h', '--help', '-H', 'Display this help message.') do
          puts opts
          exit
        end

        standard_rake_options.each { |args| opts.on(*args) }
        opts.environment('KUBEOPT')
      end.parse!
    end

    def sort_options(options)
      supported_options = %w[tasks]

      options.select! do |(switch, *)|
        switch =~ /--#{Regexp.union(supported_options)}/
      end

      super.push(version)
    end

    def default_kubeconfig
      File.expand_path('../../Kubeconfig', __FILE__)
    end

    def version
      [
        '--version', '-V',
        'Display the program version.',
        lambda do |_value|
          puts "Kubec Version: #{Kubec::VERSION} "\
               "(Rake Version: #{Rake::VERSION})"
          exit
        end
      ]
    end
  end
end
