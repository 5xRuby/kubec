namespace :status do
  desc 'Show service status'
  task :service do
    puts 'Service Status'
    Kubec::Status::Service.print
  end

  desc 'Show deployment status'
  task :deployment do
  end

  desc 'Show pod status'
  task :pod do
  end
end

desc 'Show deploy status'
task status: [
  'status:service',
  'status:deployment',
  'status:pod'
]
