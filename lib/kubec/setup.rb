include Kubec::DSL

stages.each do |stage|
  Rake::Task.define_task(stage) do
    set(:stage, stage)

    load stage_config_path.join("#{stage}.rb")
    load stack_config_path
  end
end
