einche
====
these are build instructions for an AWS EC2 Micro instance for running my own little sites and apps.  we'll save it as an AMI for later cloning.

we will be installing:

 *  Ruby 1.9
 *  Passenger & Nginx
 *  sqlite

start with a 32 bit Ubuntu 9.10 Karmic EBS boot base AMI for our availability zone (us-east). the list of the current such animals is available from [alestic](http://alestic.com/).

build AMI
------
through the [AWS Management Console](http://aws.amazon.com/console/) launch a new instance with the appropriate AMI id. select __Micro__ instance type, give the machine a nice name, use the a new or existing security group that allows just HTTP and SSH and the __appropriate__ key pair, accept other defaults. we'll associate an elastic ip with it that will allow us to refer to in consistently. 

set up an ssh alias and have at the box. log in as _ubuntu_ but switch to _root_ for most of the rest of this.

    $ ssh <your_new_machine>

install software on the server
--------

the following commands are going to be run to install all the software we need for that box. check [here](http://www.ruby-lang.org/en/downloads/) to make sure you are downloading the current stable version of ruby and substitute the where appropriate below. first . . switch to the root user.

    $ apt-get update
    $ apt-get -y install libc6-dev libssl-dev build-essential libssl-dev libreadline5-dev zlib1g-dev libcurl4-gnutls-dev sqlite3 libsqlite3-dev git-core
    $ cd /tmp
    $ mkdir src
    $ cd src
    $ wget ftp://ftp.ruby-lang.org//pub/ruby/1.9/ruby-1.9.2-p180.tar.gz
    $ tar xvf ruby-1.9.2-p180.tar.gz
    $ cd ruby-1.9.2-p180
    $ ./configure --prefix=/usr/local
    $ sudo make && sudo make install


install some gems and then passenger.

    $ gem install bundler sqlite3-ruby
    $ gem install passenger
    $ passenger-install-nginx-module

create a startup script for nginx

    $ vi /etc/init.d/nginx

paste the contents of this in the startup script

    #!/bin/sh

    ### BEGIN INIT INFO
    # Provides:          nginx
    # Required-Start:    $all
    # Required-Stop:     $all
    # Default-Start:     2 3 4 5
    # Default-Stop:      0 1 6
    # Short-Description: starts the nginx web server
    # Description:       starts nginx using start-stop-daemon
    ### END INIT INFO

    PATH=/opt/nginx/sbin:/sbin:/bin:/usr/sbin:/usr/bin
    DAEMON=/opt/nginx/sbin/nginx
    NAME=nginx
    DESC=nginx

    test -x $DAEMON || exit 0

    # Include nginx defaults if available
    if [ -f /etc/default/nginx ] ; then
            . /etc/default/nginx
    fi

    set -e

    case "$1" in
      start)
            echo -n "Starting $DESC: "
            start-stop-daemon --start --quiet --pidfile /opt/nginx/logs/$NAME.pid \
                    --exec $DAEMON -- $DAEMON_OPTS
            echo "$NAME."
            ;;
      stop)
            echo -n "Stopping $DESC: "
            start-stop-daemon --stop --quiet --pidfile /opt/nginx/logs/$NAME.pid \
                    --exec $DAEMON
            echo "$NAME."
            ;;
      restart|force-reload)
            echo -n "Restarting $DESC: "
            start-stop-daemon --stop --quiet --pidfile \
                    /opt/nginx/logs/$NAME.pid --exec $DAEMON
            sleep 1
            start-stop-daemon --start --quiet --pidfile \
                    /opt/nginx/logs/$NAME.pid --exec $DAEMON -- $DAEMON_OPTS
            echo "$NAME."
            ;;
      reload)
              echo -n "Reloading $DESC configuration: "
              start-stop-daemon --stop --signal HUP --quiet --pidfile     /opt/nginx/logs/$NAME.pid \
                  --exec $DAEMON
              echo "$NAME."
              ;;
          *)
                N=/etc/init.d/$NAME
                echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
                exit 1
                ;;
        esac

        exit 0

now set permissions . . 

    $ chmod +x /etc/init.d/nginx
    $ /usr/sbin/update-rc.d -f nginx defaults
    $ /etc/init.d/nginx start


create a user for deployments _deployer_. give it a nice password. then we are going to create a ssh key. 

    $ adduser deployer
    $ mkdir -p /var/site
    $ chown deployer:staff /var/site
    $ su deployer
    $ mkdir ~/.ssh
    $ cd ~/.ssh
    $ ssh-keygen -t rsa
    $ exit
    $ cp /home/ubuntu/.ssh/authorized_keys /home/deployer/.ssh/authorized_keys
    $ chown deployer:staff /home/deployer/.ssh/authorized_keys


copy the contents of the __/home/deployer/.ssh/id_rsa.pub__ file that was just created and add a new deploy key for any projects that we will be deploying with capistrano via github.

set the timezone (as root)

    dpkg-reconfigure tzdata


set a persistent __SRVR_TYP__ environment variable on the  in __/etc/environment__.

    SRVR_TYP=einche

since we will be using [srvr_cfgr](https://github.com/gn0m30/srvr_cfgr) to manage server configuration, set up github credentials

    git config --global user.name "<your github username>"
    git config --global user.email "<your email>"

save the AMI so we don't have to do all that again
-------------------
first reboot the instance - __BE VERY CAREFUL NOT TO TERMINATE IT__ - and make sure it's all working, that nginx comes up automatically. 

go into the [AWS Console](https://console.aws.amazon.com/ec2/home?region=us-east-1#s=Instances) select the running instance and choose _Create Image (EBS AMI)_ from the _Instance Actions_ button/menu. give it a nice name and a description and delete any AMIs (and their corresponding snapshots) that it supersedes as storage for them does cost $.

now we are ready to deploy and enjoy a mug of hot cocoa.
