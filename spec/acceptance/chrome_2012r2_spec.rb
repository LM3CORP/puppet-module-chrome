require 'spec_helper_acceptance'


describe '#chrome' do
  context 'when installing chrome on windows 2012r2' do
    it 'should install google chrome' do
      pp = <<-PP
        class {'chocolatey':} ->
        class {'chrome':
          version => '64.0.3282.16800'
        }

      PP
      result = apply_manifest(pp,:catch_failures => true )
      expect(result.exit_code).to eq 2

      result = apply_manifest(pp,:catch_failures => true )
      expect(result.exit_code).to eq 0
    end

    describe package('Google Chrome') do
      it { should be_installed }
    end
  end
end
