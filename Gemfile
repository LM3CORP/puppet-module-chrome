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
gem 'rspec-puppet-utils'
gem 'kitchen-ec2'
gem 'inspec'
gem 'kitchen-inspec'
gem 'librarian-puppet'
gem "test-kitchen"
gem 'kitchen-puppet'
gem 'kitchen-verifier-serverspec'

platforms :mswin do
  gem "win32console"
end
