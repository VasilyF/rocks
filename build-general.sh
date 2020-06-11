#!/bin/bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This build script is applicable to any OS
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
# include documents to serve

# purge documents directory and create new user-owned directory
sudo rm -rf $APACHE_DOCS_ROOT
sudo mkdir $APACHE_DOCS_ROOT
sudo chown $USER:$USER $APACHE_DOCS_ROOT

# include content to be served
cd frontend/
cp -r images pages scripts styles $APACHE_DOCS_ROOT
cd ../


# -----------------------------------------------
# set up log files

sudo mkdir -p $APACHE_LOGS_ROOT/rocks



# -----------------------------------------------
# restart Apache server
sudo apachectl restart -f $ROCKS_ROOT/apache/general/apache2-rocks-general.conf
