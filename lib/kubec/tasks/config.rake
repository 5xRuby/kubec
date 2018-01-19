# frozen_string_literal: true

namespace :config do
  desc 'Upload config files using ConfigMap'
  task push: ['deploy:namespace'] do
    Kubec::Utils::Helper.header 'Starting apply config maps'
    Kubec::Kubernetes.apply(:config)
  end

  desc 'Download config files from ConfigMap'
  task pull: ['deploy:namespace'] do
    Kubec::Utils::Helper.header 'Starting save config maps'
    Kubec::Config::Downloader.new.save
  end
end
