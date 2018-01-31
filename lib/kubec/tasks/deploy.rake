# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :deploy do
  task :namespace do
    Kubec::Kubernetes.ensure_namespace
  end

  # TODO: Add support for real kubectl
  desc 'Apply Deployment to Kubernetes'
  task :deployments do
    Kubec::Utils::Helper.header 'Starting apply deployments'
    Kubec::Kubernetes.apply(:deployment)
  end

  desc 'Apply Service to Kubernetes'
  task :services do
    Kubec::Utils::Helper.header 'Starting apply services'
    Kubec::Kubernetes.apply(:service)
  end

  desc 'Apply Service to Kubernetes'
  task :cronjobs do
    Kubec::Utils::Helper.header 'Starting apply cron jobs'
    Kubec::Kubernetes.apply(:cronjob)
  end

  desc 'Dump as config files'
  task :dump do
    puts [
      Kubec::Kubernetes.convert_to_json(secret),
      Kubec::Kubernetes.convert_to_json(config),
      Kubec::Kubernetes.convert_to_json(deployment),
      Kubec::Kubernetes.convert_to_json(service),
      Kubec::Kubernetes.convert_to_json(cronjob)
    ]
      .map(&JSON.method(:parse))
      .map(&:to_yaml)
      .join
  end
end

desc 'Deploy to Kubernetes'
task deploy: [
  'deploy:namespace',
  'secret:push',
  'config:push',
  'deploy:deployments',
  'deploy:services',
  'deploy:cronjobs'
]
