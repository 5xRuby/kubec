# frozen_string_literal: true

desc 'Restart all services'
task :restart do
  # TODO: Refactor this section
  stage = fetch(:stage, :staging)
  def scale(stage, name, size)
    `kubectl -n #{stage} scale deployment/#{name} --replicas=#{size}`
  end

  Kubec::Utils::Helper.header 'Restarting deployments'
  Kubec::Kubernetes.deployment.map do |deploy|
    Thread.new do
      puts "=> Restart #{deploy.name}"
      scale(stage, deploy.name, 0)
      scale(stage, deploy.name, deploy.replicas)
    end
  end.each(&:join)
end
