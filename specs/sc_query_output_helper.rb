module SCQueryOutputHelper
  def non_existant_service_output()
    out=<<-OUTPUT
      [SC] EnumQueryServicesStatus:OpenService FAILED 1060:

      The specified service does not exist as an installed service.
    OUTPUT
    return out
  end

  def existing_service_output(service_name)
    out=<<-OUTPUT
      SERVICE_NAME: #{service_name}
      DISPLAY_NAME: #{service_name}
              TYPE               : 20  WIN32_SHARE_PROCESS
              STATE              : 4  RUNNING
                                      (STOPPABLE,NOT_PAUSABLE,ACCEPTS_SHUTDOWN)
              WIN32_EXIT_CODE    : 0  (0x0)
              SERVICE_EXIT_CODE  : 0  (0x0)
              CHECKPOINT         : 0x0
              WAIT_HINT          : 0x0
      OUTPUT
      return out
  end
end
