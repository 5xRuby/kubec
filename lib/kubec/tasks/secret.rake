# frozen_string_literal: true

namespace :secret do
  desc 'Upload secret files'
  task push: ['deploy:namespace'] do
    Kubec::Utils::Helper.header 'Starting apply secret'
    Kubec::Kubernetes.apply(:secret)
  end

  desc 'Download secret files'
  task pull: ['deploy:namespace'] do
    Kubec::Utils::Helper.header 'Starting save secret'
    Kubec::Secret::Downloader.new.save
  end
end
