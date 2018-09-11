require 'hiera'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'puppet/util/windows'

include RspecPuppetFacts


RSpec.configure do |c|
  default_facts = {
    puppetversion: Puppet.version,
    facterversion: Facter.version
  }
  c.default_facts = default_facts
  c.color = true
  c.formatter = :documentation
  c.tty = true
  c.hiera_config = 'spec/fixtures/hiera.yaml'
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
