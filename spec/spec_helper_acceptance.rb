require 'beaker-rspec'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  windows_path = 'C:\ProgramData\PuppetLabs\code\environments\production\modules'
  module_root  = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  ignore_list  = build_ignore_list({ ignore_list: ['development/modules','.bundle','.git','.idea','.vagrant','.vendor','vendor','acceptance','bundle','spec','tests','log','pkg','example','junit'] })
  c.formatter  = :documentation
  c.before :suite do
    hosts.each do |host|
      install_dev_puppet_module_on(host, :source => module_root, :module_name => 'chrome', :target_module_path => windows_path, :ignore_list => ignore_list)
      install_dev_puppet_module_on(host, :source =>"#{module_root}/development/modules/stdlib", :module_name => 'stdlib', :target_module_path => windows_path, :ignore_list => ignore_list)
      install_dev_puppet_module_on(host, :source =>"#{module_root}/development/modules/registry", :module_name => 'registry', :target_module_path => windows_path, :ignore_list => ignore_list)
      install_dev_puppet_module_on(host, :source =>"#{module_root}/development/modules/chocolatey", :module_name => 'chocolatey', :target_module_path => windows_path, :ignore_list => ignore_list)
      install_dev_puppet_module_on(host, :source =>"#{module_root}/development/modules/powershell", :module_name => 'powershell', :target_module_path => windows_path, :ignore_list => ignore_list)
      install_dev_puppet_module_on(host, :source =>"#{module_root}/development/modules/windows_env", :module_name => 'windows_env', :target_module_path => windows_path, :ignore_list => ignore_list)
   end
  end
end
