#
# this module has data and functions for configuring a server type
#
CONFIG_FILES = %w(

)

module Configuration

  # gather/update the CONFIG_FILES from a running server
  def reap


  end

  # copy files from repo to their appropriate locations on the
  # server and then reset the configuration to make sure they are
  # being used
  def sow


    reload
  end

  #
  def reload

  end

  def diff

  end

end