# Apache Configuration

This document gives an overview of configuration directives used in the general Apache 
[configuration file](../apache/general/apache2-general.conf) as well as the corresponding module that 
uses the directive.

## Directives

### ServerRoot /srv/apache2/rocks

Directory of server, has subdirectories conf/ and logs/ relative paths are with respect to ServerRoot.

**module:** core

### ServerName localhost

Hostname/port server uses to identify itself, no port specified means will use port from incoming request.

**module:** core

### DefaultRuntimeDir /var/run/apache2

Directory where server will create runtime files (shared memory, locks).

**module:** core

### Timeout 300

Amount of time to wait for IO - time to wait for TCP packet to arrive, time to wait for an acknowledgement of packet 
from the client.

**module:** core

### KeepAlive On

Allow persistent TCP connection (session) to be used to send multiple requests.

**module:** core

### MaxKeepAliveRequests 100

Limits number of requests allowed per persistent connection. 0 for unlimited.

**module:** core

### KeepAliveTimeout 5

Seconds to wait for new request on persistent connection before closing connection

**module:** core

### HostnameLookups Off

Do not allow reverse DNS lookup in order to use hostname in logs.

**module:** core

### ErrorLog /srv/apache2/rocks/logs/error.log

File where errors are logged if ErrorLog unspecified in virtual host.

**module:** core

### AccessFileName .htaccess

Name of file containing directory-wide configurations. When serving content apache will look through each directory
along the path and execute the config files if it finds them (avoid using this - put configurations in the existing 
relevant apache config files).

**module:** core

### IncludeOptional <some/path/to/mod_lib.so>

Includes modules exposed through shared libraries if they exist.

**module:** core

### LogLevel warn

Severity of messages to insert into log file

### PidFile /var/run/apache2/apache2.pid

file to which server records the process id of the daemon.

**module:** mpm (prefork)

### Listen 127.0.0.1:80

Hostname/port on which to accept incoming requests

**module:** mpm (prefork)





### User apache

Unix user ID as which apache will handle requests. Upon startup apache uses root privileges and then demotes to lower-
privilege user to process requests.

**module:** unixd

### Group apache

Unix group ID apache lower-privilege user belongs to.

**module:** unixd


### LogFormat <format string> <name>

Specifies a format for error message logging. This format can be referenced through <name>. See the 
[official documentation](https://httpd.apache.org/docs/2.4/mod/mod_log_config.html#formats).

**module:** log_config


## Directory Directives

## FilesMatch Directives

## VirtualHost Directives


## Included Modules

