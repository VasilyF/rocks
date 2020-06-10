# Rocks

This is a toy project intended as a learning experience into creating a LAMP stack (Linux, Apache, MySQL, PHP) web 
application from scratch. The application gives users the ability to curate a gallery of rock photos.

## Getting Started

Follow these instructions to install the required software dependencies and produce a local environment where you can 
view and develop the application.

### Prerequisites

The following section briefly notes the purpose of each software dependency. It is recommended to install dependencies 
through a package manager such as apt (Debian based Linux), [Homebrew](https://brew.sh/) (MacOS) or 
[Chocolatey](https://chocolatey.org/) (Windows) since this would automatically take care of downloading and installing 
the whole ancestry of dependencies necessary. 

#### PhpStorm IDE - development only
PhpStorm is an IDE oriented towards PHP development, it is available free to use under student license (requires 
account). This is only a recommendation, feel free to use any other IDE of choice.

#### Git - development only
Git (different from Github) is version control software that is used pretty much universally in software development. 
Here's a useful [reference](https://www.atlassian.com/git/tutorials/install-git) for installing and familiarizing 
yourself with git.

#### Apache HTTP Web Server 2.4 (httpd)

Httpd is the name of the open source web server developed by the Apache Software Foundation. It is the most popular web 
server that 52% of websites rely on. For more information, consult the 
[official  Apache documentation](https://httpd.apache.org/docs/trunk/).

*What is a web server?*

A web server is a machine that is running software that allows it to listen for incoming HTTP requests, process the 
request and send back a web page. For our purposes, the machine our server will be running on is our own computer. There 
is a lot of configuration that you could do to make the Apache server do what you want, by default it will serve you 
the files in the web root directory (see below).

##### Installation

*Linux (Debian/Ubuntu)*

```
sudo apt install apache2
```

*MacOS*

Recent versions of macOS come pre-installed with Apache 2.4 however, for consistency it is easier to
unload it and then install it via Homebrew:
```
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
sudo brew install httpd
```

##### Starting the server
The server can be controlled using the apachectl interface that comes with the server
```
apachectl start
```
If working properly, the server should be serving the default welcome page at 
[http://localhost:8080](http://localhost:8080). To have it serve files that we want, we would simply put them in the 
apache web root directory. On Ubuntu this is ```/var/www/html/```, and on macOS it is ```/usr/local/var/www/``` however 
it may be different depending on operating system so make note of where the web root directory is on your machine.

#### PHP
PHP is a programming language. 

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code
* Inspiration
* etc
