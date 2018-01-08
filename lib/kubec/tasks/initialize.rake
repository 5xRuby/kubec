task :init do
  template_path = File.expand_path('../../templates', __FILE__)

  if Kubec::Application.config_exist?
    warn '[SKIP] Kubec is already setup'
    exit 1
  end

  FileUtils.cp_r("#{template_path}/.", '.')
  puts 'Kubec Initialized'
end
