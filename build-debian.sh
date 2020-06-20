#!/bin/bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This build script is specific to the kind
# of Apache configuration expected on Debian-
# based operating systems (ie. Ubuntu) and
# should not be executed on other UNIX-based
# systems (ie. Mac OSX)
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# -----------------------------------------------
# builds the application into a serviceable state
# on http://localhost/rocks.php:80
# -----------------------------------------------

APACHE_DOCS_ROOT="/var/www/rocks"
APACHE_LOGS_ROOT="/var/log/apache2"
APACHE_CONFIG_ROOT="/etc/apache2"
APACHE_BIN_ROOT="/usr/sbin"
APACHE_MODULES_ROOT="/usr/lib/apache2/modules" # do not use directly, use a2enmod
ROCKS_ROOT=$PWD


# -----------------------------------------------
# include configuration files
APACHE_DEBIAN_PROJECT_CONFIG_ROOT=apache/debian
sudo cp $APACHE_DEBIAN_PROJECT_CONFIG_ROOT/sites-available/rocks.conf $APACHE_CONFIG_ROOT/sites-available/
sudo cp $APACHE_DEBIAN_PROJECT_CONFIG_ROOT/conf-available/local-default.conf $APACHE_CONFIG_ROOT/conf-available/
sudo cp $APACHE_DEBIAN_PROJECT_CONFIG_ROOT/ports.conf $APACHE_CONFIG_ROOT/
cd $APACHE_CONFIG_ROOT/sites-available/
sudo a2dissite -q * > /dev/null 2>&1
sudo a2ensite -q rocks > /dev/null 2>&1
cd $APACHE_CONFIG_ROOT/conf-available/
sudo a2enconf -q local-default > /dev/null 2>&1
cd $ROCKS_ROOT


# -----------------------------------------------
# include documents to serve

# purge documents directory and create new user-owned directory
sudo rm -rf $APACHE_DOCS_ROOT
sudo mkdir $APACHE_DOCS_ROOT
sudo chown $USER:$USER $APACHE_DOCS_ROOT

# include content to be served
cp -r frontend/{images,pages,scripts,styles} $APACHE_DOCS_ROOT


# -----------------------------------------------
# set up log files

sudo mkdir -p $APACHE_LOGS_ROOT/rocks



# -----------------------------------------------
# restart Apache server
sudo apachectl restart




