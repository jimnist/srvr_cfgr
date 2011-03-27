server_configs
----
this project is for saving off server configuration information and is primarily used to keep different (staging and production?) servers in synch. 

each 'type' of server has a directory under servers directory.any file that is configured specifically for that type of server is listed under that directory. 

usage:
- files are edited and tested on the server

- clone the repo on a server as root, with all that is implied - creating a rsa key-pair and adding it as a deploy key to your repo.

	    cd ~
	    git clone git@github.com:gn0m30/server_configs.git
	
- set a __SERVER_CONFIG_SERVER_TYPE__ environment variable on the server the matches a server type directory.

- edit and test files on the server, adding them to the files.yml under the appropriate server type directory. the files listed in that file will be copied into the appropriate directory under the server type directory by running:
  
	    rake reap

- to synchronize a new repo, make sure sites are enabled, and restart appropriate services, run:

        rake sow

current server types:

* __einche__ - AWS server for ruby, rails3, and sinatra apps with ruby 1.9, rails3, passenger, sqlite, and ngnix. hosts the following sites:

    sassywood
    
    bankofbs
    
    idontknowmucho
    
* __tiny_ruby__ - (first server, not used anymore)

 * __other__
   just for testing, not really a server