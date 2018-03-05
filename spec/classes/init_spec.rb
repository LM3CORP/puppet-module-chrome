require 'spec_helper'

version = '64.0.3282.16800'

describe 'chrome' do
 on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
    let(:params){ {:version => version}  }
    it { is_expected.to compile }
    it { should contain_package("googlechrome-#{version}").with({'ensure' => version})  }
  end
end
end
