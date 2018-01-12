namespace :deploy do
  task :namespace do
    Kubec::Kubernetes.ensure_namespace
  end

  # TODO: Add support for real kubectl
  desc 'Apply Deployment to Kubernetes'
  task :deployments do
    puts 'Starting apply deployments'
    Kubec::Kubernetes.apply(:deployment)
  end

  desc 'Apply Service to Kubernetes'
  task :services do
    puts 'Starging apply services'
    Kubec::Kubernetes.apply(:service)
  end
end

desc 'Deploy to Kubernetes'
task deploy: [
  'deploy:namespace',
  'deploy:deployments',
  'deploy:services'
]
