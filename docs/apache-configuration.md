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

### IncludeOptional {some/path/to/config}

Includes configurations in other files (not currently used - configurations combined into one file).

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


## Directory Directives <Directory /path/to/dir>

Enclose directives that only apply to the directory and its recursive contents

**module:** core

### Options

* FollowSymLinks - the server will follow sym links within this directory
* Indexes - if directory URL requested, in the absence of a directory index.html file (or file specified by 
DirectoryIndex) then return a page of the directory contents (**useful for dev - turn off**)

**module:** core

### AllowOverride None

Determines which directives in .htaccess files can override pre-established directives. None - .htaccess files 
completely ignored.

**module:** core

### Require

Tests whether authenticated user authorized according to authorization provider and restrictions. Generic authorization 
providers included with the module:

* all granted - unconditional access
* all denied - unconditional denial of access

**module:** authz_core

## FilesMatch Directives <FilesMatch {regex}>

Enclose directives that only apply to the files that match the regex.

**module:** core

### Require

See [Require](#require)


## VirtualHost Directives <VirtualHost {host}>

Enclose directives that only apply for requests destined for a particular host. Essentially, configuration for a server 
dedicated for a particular application but in actuality runs on a single server instance that could potentially also 
serve other applications.

**module:** core

### DocumentRoot /srv/apache2/rocks/htdocs

Root directory of content served by server. URLs that map directly to server resources are relative to this directory.

**module:** core
 
### ServerName localhost

See [ServerName](#servername-localhost)

### ErrorLog /srv/apache2/rocks/logs/error.log

See [ErrorLog](#errorlog-srvapache2rockslogserrorlog)

### CustomLog /srv/apache2/rocks/logs/access.log combined

Specifies log file for server access logs and log format to use (declared previously).

**module:** log_config

## IfModule Directives <IfModule {module}>

TODO

# Directives TODO - later
* DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm -> mod_dir



## Enabled Modules

### dir

Serving of directory index files.

### env

Modifies environment variables passed to CGI script

### mime

Associates the requested filename's extensions with the file's behavior (handlers and filters) and content (mime-type, 
language, character set and encoding).

### alias

Control of URLs of incoming requests, mapping URL to filesystem resources, redirects - asking client to fetch different 
URL.

### filter

Allows context-dependent (smart) application of filters.

### status

Provides server status information about activity and performance.

### php7.2

Enable interpreting for .php files.

### deflate

Provides compression of content before it is sent to the client

### setenvif

Allows setting environment variables based on characteristics of request (ie. browser, host address)

### autoindex

Generates directory indexes automatically - a page listing the files in the directory.

### auth_basic

Basic HTTP authentication.

### authn_core

Core authentication capabilities, directives common to all authentication providers.

### authn_file

User authentication by looking up users in plain text password files.

### authz_core

Core authorization capabilities.

### authz_host



### authz_user



### reqtimeout



### negotiation



### mpm_prefork



### access_compat


