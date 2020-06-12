#!/bin/bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This build script is intended to be run
# on any UNIX/POSIX OS it places relevant
# files into /srv/apache2/
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# -----------------------------------------------
# builds the application into a serviceable state
# on http://localhost/rocks.php:80
#
# Arguments
# $1 - start | restart | stop
# $2 - absolute path to apache2 executable
# -----------------------------------------------

# APACHE_BIN_ROOT="/usr/sbin" -- determine the path to the apache2/httpd binary

APACHE_BIN=${2:-/usr/sbin/apache2}

APACHE_ROCKS_ROOT="/srv/apache2/rocks"
APACHE_DOCS_ROOT="$APACHE_ROCKS_ROOT/docs"
APACHE_LOGS_ROOT="$APACHE_ROCKS_ROOT/log"
APACHE_CONFIG_ROOT="$APACHE_ROCKS_ROOT/etc"

# -----------------------------------------------
# purge /srv/apache2/rocks
sudo rm -rf $APACHE_ROCKS_ROOT
sudo mkdir -p $APACHE_ROCKS_ROOT
chown $USER:$USER $APACHE_ROCKS_ROOT

# -----------------------------------------------
# include documents to serve in /srv/apache2/rocks/docs
mkdir $APACHE_DOCS_ROOT
cp -r frontend/{images,pages,scripts,styles} $APACHE_DOCS_ROOT

# -----------------------------------------------
# set up log files
sudo mkdir -p $APACHE_LOGS_ROOT

# -----------------------------------------------
# restart Apache server
sudo apachectl restart -f apache/general/apache2-rocks-general.conf
sudo $APACHE_BIN -d $APACHE_CONFIG_ROOT/apache2-rocks-general.conf -k start