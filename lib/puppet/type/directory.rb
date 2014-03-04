require 'puppet/parameter/boolean'

Puppet::Type.newtype(:directory) do
  @doc = "Manage a directory"

  ensurable

  newparam(:path, :namevar => true) do
    desc "The path of the directory"

    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end
  end

  newproperty(:owner) do
    desc "The owner of the directory"

    validate do |value|
      unless value =~ /^\w+/
        raise ArgumentError, "%s is not a valid user name" % value
      end
    end
  end

  newproperty(:group) do
    desc "The group of the directory"

    validate do |value|
      unless value =~ /^\w+/
        raise ArgumentError, "%s is not a valid group name" % value
      end
    end
  end

  newproperty(:mode) do
    desc "The mode of the directory"

    # TODO(richardc): validate/munge
  end

  newparam(:recurse, :boolean => true, :parent => Puppet::Parameter::Boolean) do
  end

  autorequire(:directory) do
    Pathname.new(self[:path]).parent.to_s
  end

  autorequire(:file) do
    # try and avoid confusion, conflict with a file resource of the same path
    if catalog.resource(:file, self[:path])
      raise "Cannot have a File[#{self[:path]}] and Directory[#{self[:path]}]"
    end

    Pathname.new(self[:path]).parent.to_s
  end
end
