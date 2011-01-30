# TODO: common code for server configurations
#
module CommonConfiguration

  # gather/update the CONFIG_FILES from a running server
  def reap
    CONFIG_FILES.each do |srvr_cfg_file|
      # make sure the directory exists in the repo tree
      repo_dir = File.join(REPO_FILES_ROOT, File.dirname(srvr_cfg_file))
      FileUtils.mkdir_p(repo_dir) unless File.exists?(repo_dir) && File.directory?(repo_dir)

      repo_cfg_file = File.join(REPO_FILES_ROOT, srvr_cfg_file)
      puts "  moving #{srvr_cfg_file} to #{repo_cfg_file}"
      FileUtils.cp(srvr_cfg_file, repo_cfg_file)
    end
  end

  # copy files from repo to their appropriate locations on the
  # server and then reset the configuration to make sure they are
  # being used. NOSTE the src here is really the destination of the
  # copy
  def sow
    CONFIG_FILES.each do |srvr_cfg_file|
      # make sure the directory exists in the repo tree
      srvr_dir = File.dirname(srvr_cfg_file)
      FileUtils.mkdir_p(srvr_dir) unless File.exists?(srvr_dir) && File.directory?(srvr_dir)

      repo_cfg_file = File.join(REPO_FILES_ROOT, srvr_cfg_file)
      puts "  moving #{repo_cfg_file} to #{srvr_cfg_file}"
      FileUtils.cp(repo_cfg_file, srvr_cfg_file)
    end

    reload
  end

  def diff
    # TODO:
  end

  def calculate_repo(src)

  end

end