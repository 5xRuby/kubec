desc 'Deploy to Kubernetes'
namespace :deploy do
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
