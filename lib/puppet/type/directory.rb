Puppet::Type.newtype(:directory) do
  @doc = "Manage a directory"

  ensurable

  newproperty(:path, :namevar => true) do
    desc "The path of the directory"
    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end
  end

  newproperty(:owner) do
    desc "The owner of the directory"

    # TODO(richardc): validate/munge
  end

  newproperty(:group) do
    desc "The group of the directory"

    # TODO(richardc): validate/munge
  end

  newproperty(:mode) do
    desc "The mode of the directory"

    # TODO(richardc): validate/munge
  end

  newparameter(:recurse, :boolean => true, :parent => Puppet::Parameter::Boolean) do
  end

  autorequire(:directory) do
    catalog.resources.find_all { |r|
      r.is_a?(Puppet::Type.type(:directory)) and r[:target] == self[:path]
    }
  end
end
