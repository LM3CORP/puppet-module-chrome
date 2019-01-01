require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'rake'
require 'rspec/core/rake_task'
require 'yaml'


Rake::Task[:default].clear
Rake::Task[:lint].clear  #https://github.com/rodjek/puppet-lint/issues/331
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send('disable_class_inherits_from_params_class')

PuppetLint::RakeTask.new :lint do |config|
    config.ignore_paths   = ["spec/**/*.pp", "vendor/**/*.pp", "development/modules/**/*.pp"]
    config.log_format     = '%{path}:%{linenumber}:%{KIND}: %{message}'
end

@module = YAML.load_file('.module.yml')

desc "Validate manifests, (erb/epp)templates, and ruby files"
task :check do
    Dir['manifests/**/*.pp'].each do |manifest|
      sh "puppet parser validate --noop #{manifest}"
    end

    Dir['spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
      sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
    end

    Dir['templates/**/*.erb'].each do |erb_file|
      sh "erb -P -x -T '-' #{erb_file} | ruby -c"
    end

    Dir['templates/**/*.epp'].each do |epp_file|
      sh "puppet epp validate #{epp_file} | ruby -c"
    end
end


desc "Prepare symbolic link to root puppet module folders"
task :symlink do
  FileUtils.remove_dir("development/modules/#{@module['name']}",:verbose => true)
  FileUtils.mkdir_p "development/modules/#{@module['name']}"
  FileUtils.cd "development/modules/#{@module['name']}"
  system 'cp -r "../../../manifests" "manifests"'
  system 'cp -r "../../../files" "files"'
end

desc "Download third-party modules"
task :r10k do
    system 'r10k puppetfile install -v'
end

task :default => [:r10k, :check, :lint, :spec]

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
