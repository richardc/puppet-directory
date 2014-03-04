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
      it { should be_owned_by('root') }
      it { should be_grouped_into('root') }
    end
  end

  describe 'ownership management' do
    it 'should create a file with ownership' do
      pp = <<-EOS
        directory { '/tmp/test2':
          ensure => present,
          owner => 'nobody',
          group => 'nogroup',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/tmp/test2') do
      it { should be_directory }
      it { should be_owned_by('nobody') }
      it { should be_grouped_into('nogroup') }
    end
  end

  describe 'recursion' do
    it 'should create nested directories' do
      pp = <<-EOS
        directory { '/tmp/foo/bar/baz':
          ensure => present,
          recurse => true,
          owner => 'nobody',
          group => 'nogroup',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/tmp/foo/bar') do
      it { should be_directory }
      it { should be_owned_by('root') }
      it { should be_grouped_into('root') }
    end

    describe file('/tmp/foo/bar/baz') do
      it { should be_directory }
      it { should be_owned_by('nobody') }
      it { should be_grouped_into('nogroup') }
    end
  end
end
