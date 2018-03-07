source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['= 5.4']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper'
gem 'puppet-lint'
gem 'serverspec'
gem 'facter'
gem 'hiera'
gem 'r10k'
gem 'winrm'
gem 'rspec-puppet'
gem 'rspec-puppet-facts'
gem 'puppet-strings'
gem 'beaker'
gem 'beaker-rspec'
gem 'beaker-puppet'
gem 'beaker-puppet_install_helper'
gem 'beaker-testmode_switcher'
gem 'rspec-puppet-utils'

platforms :mswin do
  gem "win32console"
end
