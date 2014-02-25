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
    # TODO(richardc): autodepend on parent paths
  end

  autorequire(:file) do
    # TODO(richardc): autodepend on parent paths, also check if ensure != file
    # TODO(richardc): conflict with file resource with same path
  end
end
