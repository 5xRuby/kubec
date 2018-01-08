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

    def top_level_tasks
      has_config = DEFAULT_KUBECFILES.map { |f| File.exist?(f) }.reduce(:|)
      return @top_level_tasks if has_config
      return @top_level_tasks if default_tasks.include?(@top_level_tasks.first)

      @top_level_tasks.unshift(warning_not_init.to_s)
    end

    private

    def warning_not_init
      Rake::Task.define_task(:warning_not_init) do
        puts 'Kubeconfig isn\'t init'
        exit 1
      end
    end

    def default_tasks
      %w[init]
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
