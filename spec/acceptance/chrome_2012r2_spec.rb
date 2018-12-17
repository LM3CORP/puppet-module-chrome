require_relative 'spec_windowshelper'

describe package('Google Chrome') do
  it { should be_installed }
end
