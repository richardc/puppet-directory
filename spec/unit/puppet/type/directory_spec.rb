require 'spec_helper.rb'
require 'puppet'
require 'puppet/type/directory'

describe Puppet::Type.type(:directory) do
  before :each do
    @directory = Puppet::Type.type(:directory).new({
      :name => '/usr/lib/madeup',
      :owner => 'me',
      :group => 'us',
    })
  end

  it 'should require a name' do
    expect {
      Puppet::Type.type(:directory).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should have a path' do
    @directory[:path].should == '/usr/lib/madeup'
  end

  it 'should fail with a non-qualified path' do
    expect {
      Puppet::Type.type(:directory).new({:name => 'foo/bar'})
    }.to raise_error /File paths must be fully qualified/
  end

  it 'should have an owner' do
    @directory[:owner].should == 'me'
  end

  it 'should have a group' do
    @directory[:group].should == 'us'
  end
end
