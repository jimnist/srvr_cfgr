srvr_cfgr
----
this project provides a __SUPER SIMPLE__ method for managing server configuration files. useful for keeping servers in synch and storing server configuration information and documentation.

information and is primarily used to keep different (staging and production?) servers in synch. 

each 'type' of server has a directory under servers directory.any file that is configured specifically for that type of server is listed under that directory. 

usage
----
fork this repo.

clone your repo on a server as a user that has write access to all the files you need to manage. this user will need an rsa key-pair that has been added as a deploy key to your repo.

    cd ~
    git clone git@github.com:gn0m30/server_configs.git

set a persistent __SRVR_TYP__ environment variable on the server the matches a server type directory.

you can edit and test files on the server, adding them to the __CONFIG_FILES__ array in the __configuration.rb__ file under the appropriate server type directory. the files listed in that file will be copied into the appropriate directory under the server type directory AND any other code that you put in the __reload__ method in the file will be executed by running:
  
    rake reap

to synchronize a server with the repo, run:

    rake sow

current server types:

* __einche__ - AWS server for ruby, rails3, and sinatra apps with ruby 1.9, rails3, passenger, sqlite, and ngnix. 
    
* __tiny_ruby__ - first server, not used anymore

* __template__ - just a server template


TODO:
----

* make __diff__ work.
