# Abandoned

This spike has been abandoned for now.

If you need the ability to simply create a directory recursively, please check out the
[dirtree resource type](https://github.com/puppetlabs/pltraining-dirtree#dirtree-resource-type)

#

A directory type for puppet

    directory { '/var/lib/myapp':
       recurse => true,
       owner   => 'myapp',
       group   => 'myapp',
       mode    => '0755',
    }


# Parameters

## recurse

Boolean, defaults to false.  True means make all non-existing
intermediate directories.  Ownership/modes will only apply to the
leaf node.

## owner

String, no default.  Who should own the leaf directory.

## group

String, no default.  What group should own the leaf directory.

## mode


