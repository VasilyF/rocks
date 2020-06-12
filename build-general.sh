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
# $2 - absolute path to apache2 executable (other)
# -----------------------------------------------

# check arguments -- put echo statements


# -----------------------------------------------
# determine the path to the apache2/httpd binary
if [ -f $2 ]; then
  # get path to executable from argument
  APACHE_BIN=$2;
else
  # look for executable in path
  for path in ${PATH//:/ }; do
    if [ -f $path/apache2 ]; then
      APACHE_BIN=$path/apache2
      break
    elif [ -f $path/httpd ]; then
      APACHE_BIN=$path/httpd
      break
    fi
  done
fi

if [ -z $APACHE_BIN ]; then
  echo "could not locate apache executable... "
  echo "you should either: "
  echo "1) explicitly provide the absolute path to the executable as the second argument"
  echo "ie. ./build-general.sh start /usr/sbin/apache2"
  echo "2) make sure that the executable can be found in the PATH variable"
  echo "terminating script..."
  return 1
fi

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