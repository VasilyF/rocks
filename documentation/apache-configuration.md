# Apache Configuration

This document gives an overview of configuration directives used in the general Apache 
[configuration file](../apache/general/apache2-general.conf) as well as the corresponding module that 
uses the directive.

## Context Directives

### Directory Directives <Directory {directory}>

Enclose directives that only apply to the directory and its recursive contents

**module:** core

### FilesMatch Directives <FilesMatch {regex}>

Enclose directives that only apply to the files that match the regex.

**module:** core

### VirtualHost Directives <VirtualHost {host}>

Enclose directives that only apply for requests destined for a particular host. Essentially, configuration for a server 
dedicated for a particular application but in actuality runs on a single server instance that could potentially also 
serve other applications.

**module:** core

### IfModule Directives <IfModule {module}>

Directives are only invoked if module is present, {module} is either the module identifier or the mod_example.c file 
containing STANDARD20_MODULE_STUFF that gets compiled into the module.

**module:** core





## Directives - mod_core

### AccessFileName .htaccess

Name of file containing directory-wide configurations. When serving content apache will look through each directory
along the path and execute the config files if it finds them (avoid using this - put configurations in the existing 
relevant apache config files).

### AllowOverride None

Determines which directives in .htaccess files can override pre-established directives. None - .htaccess files 
completely ignored.

### DefaultRuntimeDir /var/run/apache2

Directory where server will create runtime files (shared memory, locks).

### DocumentRoot /srv/apache2/rocks/htdocs

Root directory of content served by server. URLs that map directly to server resources are relative to this directory.

### ErrorLog /srv/apache2/rocks/logs/error.log

File where errors are logged if ErrorLog unspecified in virtual host.

### HostnameLookups Off

Do not allow reverse DNS lookup in order to use hostname in logs.

### IncludeOptional {some/path/to/config}

Includes configurations in other files (not currently used - configurations combined into one file).

### KeepAlive On

Allow persistent TCP connection (session) to be used to send multiple requests.

### KeepAliveTimeout 5

Seconds to wait for new request on persistent connection before closing connection

### LogLevel warn

Severity of messages to insert into log file

### MaxKeepAliveRequests 100

Limits number of requests allowed per persistent connection. 0 for unlimited.

### Options

* FollowSymLinks - the server will follow sym links within this directory
* Indexes - if directory URL requested, in the absence of a directory index.html file (or file specified by 
DirectoryIndex) then return a page of the directory contents (**useful for dev - turn off**)

### ServerName localhost

Hostname/port server uses to identify itself, no port specified means will use port from incoming request.

### ServerRoot /srv/apache2/rocks

Directory of server, has subdirectories conf/ and logs/ relative paths are with respect to ServerRoot.

### Timeout 300

Amount of time to wait for IO - time to wait for TCP packet to arrive, time to wait for an acknowledgement of packet 
from the client.





## Directives - mpm_prefork_module

### Listen 127.0.0.1:80

Hostname/port on which to accept incoming requests

### PidFile /var/run/apache2/apache2.pid

file to which server records the process id of the daemon.





## Directives - mod_unixd

### Group apache

Unix group ID apache lower-privilege user belongs to.

### User apache

Unix user ID as which apache will handle requests. Upon startup apache uses root privileges and then demotes to lower-
privilege user to process requests.





## Directives - mod_log_config

### CustomLog /srv/apache2/rocks/logs/access.log combined

Specifies log file for server access logs and log format to use (declared previously).

### LogFormat <format string> <name>

Specifies a format for error message logging. This format can be referenced through <name>. See the 
[official documentation](https://httpd.apache.org/docs/2.4/mod/mod_log_config.html#formats).





## Directives - mod_authz_core

### Require

Tests whether authenticated user authorized according to authorization provider and restrictions. Generic authorization 
providers included with the module:

* all granted - unconditional access
* all denied - unconditional denial of access





## Enabled Modules

### access_compat

Authorization based on host.

### alias

Control of URLs of incoming requests, mapping URL to filesystem resources, redirects - asking client to fetch different 
URL.

### auth_basic

Basic HTTP authentication.

### authn_core

Core authentication capabilities, directives common to all authentication providers.

### authn_file

User authentication by looking up users in plain text password files.

### authz_core

Core authorization capabilities.

### authz_host

Authorization based on host address.

### authz_user

Authorization based on user.

### autoindex

Generates directory indexes automatically - a page listing the files in the directory.

### deflate

Provides compression of content before it is sent to the client.

### dir

Serving of directory index files.

### env

Modifies environment variables passed to CGI script

### filter

Allows context-dependent (smart) application of filters.

### mime

Associates the requested filename's extensions with the file's behavior (handlers and filters) and content (mime-type, 
language, character set and encoding).

### mpm_prefork

Multi-processing module handling the strategy with which the server handles requests regarding process forking and 
threading.

### negotiation

Provides content negotiation (media type, language, character set, encoding).

### php7.2

Enable interpreting for .php files.

### reqtimeout

Control the minimum rate of data flow on a connection and timeout on idle requests before closing.

### setenvif

Allows setting environment variables based on characteristics of request (ie. browser, host address).

### status

Provides server status information about activity and performance.





# Directives TODO - later
* DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm -> mod_dir
* LoadModule
* TypesConfig
* AddType
* RemoveType
* AddLanguage
* AddCharset
* AddHandler
* SetHandler
* AddOutputFilter
* ExtendedStatus
* ProxyStatus
* php_admin_flag
* AddOutputFilterByType
* BrowserMatch
* IndexOptions
* AddIconByEncoding
* AddIconByType
* AddIcon
* DefaultIcon
* ReadmeName
* HeaderName
* IndexIgnore
* RequestReadTimeout
* LanguagePriority
* ForceLanguagePriority
* StartServers
* MinSpareServers
* MaxSpareServers
* MaxRequestWorkers
* MaxConnectionsPerChild
