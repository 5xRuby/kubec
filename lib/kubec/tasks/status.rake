namespace :status do
  desc 'Show service status'
  task :service do
    Kubec::Utils::Helper.header 'Service Status'
    Kubec::Status::Service.print
  end

  desc 'Show deployment status'
  task :deployment do
    Kubec::Utils::Helper.header 'Deployment Status'
    Kubec::Status::Deployment.print
  end

  desc 'Show pod status'
  task :pod do
    Kubec::Utils::Helper.header 'Pod Status'
    Kubec::Status::Pod.print
  end
end

desc 'Show deploy status'
task status: [
  'status:service',
  'status:deployment',
  'status:pod'
]
