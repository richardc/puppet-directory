Puppet::Type.type(:directory).provide(:unix) do
  desc "Directory provider for UNIXy POSIXy things"

  def exists?
    File.exists?(resource[:path]) && File.directory?(resource[:path])
  end

  def create
    Dir.mkdir(resource[:path])

    uid = nil
    if resource[:owner]
      uid = Etc.getpwnam(resource[:owner]).uid
    end

    gid = nil
    if resource[:group]
      gid = Etc.getgrnam(resource[:group]).gid
    end

    if uid or gid
      File.chown(uid, gid, resource[:path])
    end
  end

  def destroy
    Dir.unlink(resource[:path])
  end

  def owner
    if exists?
      uid = File.stat(resource[:path]).uid
      Etc.getpwuid(uid).name
    else
      return :absent
    end
  end

  def owner=(newowner)
    user = Etc.getpwnam(newowner)
    File.chown(user.uid, nil, resource[:path])
  end

  def group
    if exists?
      gid = File.stat(resource[:path]).gid
      Etc.getgrgid(gid).name
    else
      return :absent
    end
  end

  def group=(newgroup)
    group = Etc.getgrnam(newgroup)
    File.chown(nil, group.gid, resource[:path])
  end

  def mode
    if exists?
      "%o" % (File.stat(resource[:path]).mode & 007777)
    else
      :absent
    end
  end

  def mode=(value)
    File.chmod(Integer("0" + value), resource[:path])
  end
end
