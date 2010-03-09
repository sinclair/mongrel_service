module ServiceManager
  class CreateError < StandardError; end
  class ServiceNotFound < StandardError; end
  class ServiceError < StandardError; end

  class ServiceStruct < Struct.new(:service_name, :display_name, :binary_path_name)
  end

  class CommandLine
    def self.exec(cmd, *args)
      output = `#{cmd} #{args.join(' ')} 2>&1`
      return [$?.exitstatus, output]
    end
  end

  def self.create(service_name, display_name, binary_path_name)
    cmd = ['create']
    cmd << service_name
    cmd << "DisplayName=" << display_name.inspect
    cmd << "binPath=" << binary_path_name.inspect
    status, out = sc(*cmd)
    raise CreateError.new(out) unless status == 0

    return true
  end

  def self.exist?(service_name)
    status, out = sc('query', service_name)
    out =~ /#{service_name}/i
  end

  def self.open(service_name)
    status, out = sc('qc', service_name, 4096)
    raise ServiceNotFound.new(out) unless status == 0

    out =~ /BINARY\_PATH\_NAME.*\: (.*)$/
    binary_path_name = $1.strip

    out =~ /DISPLAY\_NAME.*\: (.*)$/
    display_name = $1.strip

    svc = ServiceStruct.new(service_name, display_name, binary_path_name)

    yield svc if block_given?
    svc
  end

  def self.getdisplayname(service_name)
    status, out = sc('GetDisplayName', service_name)
    raise ServiceNotFound.new(out) unless status == 0

    out =~ /\=(.*)$/
    $1.strip
  end

  def self.stop(service_name)
    status, out = net('stop', service_name)
    raise ServiceError.new(out) unless status == 0

    return true
  end

  def self.delete(service_name)
    status, out = sc('delete', service_name)
    raise ServiceError.new(out) unless status == 0

    return true
  end

  private

  def self.sc(*args)
    CommandLine.exec('sc', args)
  end

  def self.net(*args)
    CommandLine.exec('net', args)
  end

end
