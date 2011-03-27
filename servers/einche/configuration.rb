#
# this module has data and functions for configuring a server type
#
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "common_configuration")

#  /opt/nginx/conf/sites-available/ctrain

#  /opt/nginx/conf/sites-available/bankofbs

CONFIG_FILES = %w(
  /opt/nginx/conf/nginx.conf
  /opt/nginx/conf/sites-available/sassywood
)

module Configuration

  include CommonConfiguration

  # commands to reset a server to a current
  def reload
    # makes sure the sites are enabled
    CONFIG_FILES.each do |cfg|
      if cfg.include?('sites-available')
        link = cfg.gsub('sites-available', 'sites-enabled')

        # make sure the sites-enabled directory exists
        enabled_dir = File.dirname(link)
        FileUtils.mkdir_p(enabled_dir) unless File.exists?(enabled_dir) && File.directory?(enabled_dir)

        FileUtils.ln_sf  cfg, link unless File.exists?(link)
      end
    end

    system('/etc/init.d/nginx reload')
  end

end
