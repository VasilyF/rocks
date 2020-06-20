# Rocks

This is a toy project intended as a learning experience into creating a LAMP stack (Linux, Apache, MySQL, PHP) web 
application from scratch. The application gives users the ability to curate a gallery of rock photos.

## Installation

Follow these instructions to install the required software dependencies for developing and running the application on 
a local machine.

It is recommended to install dependencies through a package manager such as apt (Debian based Linux), 
[Homebrew](https://brew.sh/) (Mac OS) or [Chocolatey](https://chocolatey.org/) (Windows) since this would automatically 
take care of downloading and installing the whole ancestry of dependencies necessary. Homebrew and Chocolatey are 
probably not installed on systems by default, follow the instructions in the links to install the appropriate 
package manager.

**NOTE:** On windows it is possible to install Apache, MySQL and PHP all in one go with:

```shell script
choco install wamp-server
```

### Git
Git is version control software used for application development.

* Official [documentation](https://www.atlassian.com/git/tutorials/what-is-version-control).
* Atlassian's beginner friendly [overview](https://www.atlassian.com/git/tutorials/what-is-version-control).

#### Debian/Ubuntu

```shell script
sudo apt install git
```

#### Mac OS

```shell script
brew install git
```

#### Windows

```shell script
choco install git
```

---

To check if git was installed successfully, the following should display a version message:

```shell script
git --version
```

### Apache HTTP Web Server 2.4 (httpd)

Apache HTTP Web Server, otherwise known as Httpd, is the name of the open source web server developed by the Apache 
Software Foundation. 

* Official [documentation](https://httpd.apache.org/docs/trunk/).

#### Debian/Ubuntu

```shell script
sudo apt install apache2
```

#### Mac OS

Recent versions of Mac OS X come with a pre-installed version of Apache 2.4, although it is also possible to uninstall 
and re-install Apache using Homebrew if desired (for consistency):

``` shell script
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
brew install httpd
```

#### Windows

```shell script
choco install apache-httpd
```

---

To check if Apache was installed successfully, start the server: 

```shell script
sudo apachectl start
```

Then, in a browser, go to [http://localhost:80](http://localhost:80). Apache should serve a default information page.

#### MySQL

MySQL is a database server used for storing information relevant to the application. 

* Official [documentation](https://dev.mysql.com/doc/refman/8.0/en/).
* Beginner friendly [tutorials](https://www.mysqltutorial.org/getting-started-with-mysql/).

#### Debian/Ubuntu

```shell script
sudo apt install mysql-server
```

#### Mac OS

```shell script
brew install mysql
```

#### Windows

```shell script
choco install mysql
```

---

To check if MySQL was installed successfully, the following should display a version message:

```shell script
mysql --version
```


#### PHP

PHP is an interpreted programming language. To generate web content the server would use the interpreter and pass to it 
a file to execute (ie. index.php) the PHP interpreter would run the code and produce the output html that gets sent 
back to the client. To use PHP with Apache we need the recent version of the PHP interpreter, and the module 
to serve as the glue between PHP and Apache. We will also use an extension that will expose functions for connecting to 
and making queries against the MySQL database.

#### Debian/Ubuntu

```shell script
sudo apt install php libapache2-mod-php php-mysql
```

#### Mac OS

Should already be installed:

```shell script
php --version
```

Otherwise:

```shell script
brew install php
```

#### Windows

```shell script
choco install php
```

---

To check if the PHP interpreter was installed successfully, the following should display a version message:

```shell script
php --version
```

To check that Apache is using the PHP module, [clone](#cloning-repository) and [build](#building-application) the 
application and make sure content is displayed properly in the browser. 

The application at present does not use the MySQL server. To test that PHP is able to use the `mysqli` 
extension to connect and query MySQL:

1. Following guides on [mysqltutorial.org](https://www.mysqltutorial.org/mysql-administration.aspx):
    1. Connect to the MySQL server through the command line as the root user.
    2. Create a database called `test_db`
    3. Create a user `test_user` with password `test_pass`
    4. Grant `test_user` all permissions on `test_db` database
2. Create a file `test-mysql.php` with the following contents:
    ```php
    <?php
        $mysqli = new mysqli('localhost', 'test_user', 'test_pass', 'test_db');
        if(!$mysqli->connect_errno){
            echo "[SUCCESS]";
        } else {
            echo "[ERROR] - " . $mysqli->connect_errno . " - " . $mysqli->connect_error;
        }
    ?>
    ```
3. execute the script: 
    `php test-mysql.php`

## Cloning Repository

Cloning will bring all the files from github onto your local computer inside a 'rocks' folder within the folder where 
the `git clone` command was issued. It is recommended that you create a new folder (ie. workspace) into which you would 
clone any repositories. In order to clone the repository you need to be added as a contributor (contact me).

### Using HTTPS

Using https will require you to authenticate (with your account password) whenever you connect to your account through 
the command line (ie. to clone a repository).

```shell script
git clone https://github.com/VasilyF/rocks.git
```

### Using SSH

Using ssh will allow you to automatically authenticate yourself whenever connecting to github from the command line 
(ie. to clone a repository), you will not have to enter a password each time.

Follow these [steps](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) to 
generate an SSH key and add it to your account. 

```shell script
git clone https://github.com/VasilyF/rocks.git
```

## Building Application

The application can be built on UNIX based systems (Linux/Mac OS) using the general-build.sh script. 

**Windows:** currently no build script exists, need to build off apache2-general.conf

### Specifying Local Environment Variables

Prior to running the script, some local environment variables need to be set up. Since Apache is installed differently 
on each operating system, in order to start the server it is necessary to specify: 

1. The absolute path to the apache2 (could also be called httpd) binary executable, this is the server program itself
the following are likely places where it would be installed but check and/or do some googling to find it.
    * /usr/sbin/apache2
2. The directory under which all the Apache modules (shared libraries) are stored.
the following are likely places where it would be installed:
    * /usr/lib/apache2/modules
    * /usr/libexec/apache2/modules
    
Create a new file called (exactly) `envvars-local.sh` in the directory `rocks/apache/general/` and paste the following 
contents into the file:

```shell script
export APACHE_BIN=</usr/sbin/apache2>
export APACHE_MODULES_DIR=</usr/libexec/apache2/modules>
```

Replace the contents inside the angle brackets with the actual paths of (1) and (2) respectively.

**Note:** when specifying the path to the modules directory (2) the trailing '/' should be omitted.

### Running Build Script

The build script build-general.sh is meant to be executed from the `rocks/` directory (root directory of project). 
It places all the server related content (log files, config files, documents to serve) into `/srv/apache2/rocks`. 
It could be used as follows to start, stop and restart the server:

#### Start Server

```shell script
sudo ./build-general.sh start
```

#### Stop Server

```shell script
sudo ./build-general.sh stop
```

#### Restart Server

This is useful to incorporate changes made in the code into the content being served by Apache.

```shell script
sudo ./build-general.sh restart
```

## Wiki

Further resources are available in the github [wiki](https://github.com/VasilyF/rocks/wiki).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
