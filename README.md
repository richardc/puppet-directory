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


