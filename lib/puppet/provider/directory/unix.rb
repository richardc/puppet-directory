Puppet::Type.type(:directory).provide(:unix) do
  desc "Directory provider for UNIXy POSIXy things"

  def exists?
    File.exists?(resource[:path]) && File.directory?(resource[:path])
  end

  def create
    Dir.mkdir(resource[:path])
  end

  def destroy
    Dir.unlink(resource[:path])
  end

  def owner
    if exists?
      File.stat(resource[:path]).uid
    else
      return :absent
    end
  end

  def owner=(newowner)
  end

  def group
    if exists?
      # TODO(richardc): should map to name?
      File.stat(resource[:path]).gid
    else
      return :absent
    end
  end

  def group=(newgroup)
    File.chown(nil, newgroup, resource[:path])
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
