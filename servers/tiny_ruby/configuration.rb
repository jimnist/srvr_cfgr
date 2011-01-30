#
# this module has data and functions for configuring a server type
#
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "common_configuration")

CONFIG_FILES = %w(
  /opt/nginx/conf/nginx.conf
)

module Configuration

  include CommonConfiguration

  # commands to reset a server to a current
  def reload
    system('/etc/init.d/nginx reload')
  end

end