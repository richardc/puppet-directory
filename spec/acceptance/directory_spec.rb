require 'spec_helper_acceptance'

describe 'directory type' do
  describe 'simple directory in /tmp' do
    it 'should work with no errors' do
      pp = <<-EOS
        directory { '/tmp/foo_bar_baz':
          ensure => present,
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/tmp/foo_bar_baz') do
      it { should be_directory }
    end
  end
end
