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
end

desc 'Deploy to Kubernetes'
task deploy: [
  'deploy:namespace',
  'deploy:deployments',
  'deploy:services',
  'deploy:cronjobs'
]
