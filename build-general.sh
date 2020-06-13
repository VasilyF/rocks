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

echo "------------------------------------------"

# -----------------------------------------------
# check command argument is present
CMD=$1
if [[ ! "$CMD" =~ ^(start|stop|restart)$ ]]; then
    echo "invalid command... needs to be one of start | stop | restart"
    echo "ie. ./build-general.sh start usr/sbin/apache2"
    exit 1
fi


# -----------------------------------------------
# determine the path to the apache2/httpd binary
if [ $2 ]; then
  # get path to executable from argument
  APACHE_BIN=$2;
  echo "using apache executable: $APACHE_BIN"
else
  # look for executable in path
  echo "apache executable not provided, looking in PATH..."
  for path in ${PATH//:/ }; do
    if [ -f $path/apache2 ]; then
      APACHE_BIN=$path/apache2
      echo "using apache executable: $APACHE_BIN"
      break
    elif [ -f $path/httpd ]; then
      APACHE_BIN=$path/httpd
      echo "using apache executable: $APACHE_BIN"
      break
    fi
  done
fi

if [ -z $APACHE_BIN ]; then
  echo "could not locate apache executable... "
  echo "you should either: "
  echo "1) explicitly provide the absolute path to the executable as the second argument"
  echo "ie. ./build-general.sh start /usr/sbin/apache2"
  echo "2) make sure that the executable can be found using the PATH variable"
  exit 1
fi

if [ $CMD == "stop" ]; then
  echo "stopping server..."

  $APACHE_BIN -k $CMD
  {
    [ $? -eq 0 ] &&
    {
      echo "server stopped"
      exit 0
    }
  } || {
    echo "error occurred while stopping server"
    exit 1
  }
fi

APACHE_ROCKS_ROOT="/srv/apache2/rocks"
APACHE_DOCS_ROOT="$APACHE_ROCKS_ROOT/htdocs"
APACHE_LOGS_ROOT="$APACHE_ROCKS_ROOT/logs"
APACHE_CONFIG_ROOT="$APACHE_ROCKS_ROOT/conf"

echo "purging $APACHE_ROCKS_ROOT..."

# -----------------------------------------------
# purge /srv/apache2/rocks
sudo rm -rf $APACHE_ROCKS_ROOT
sudo mkdir -p $APACHE_ROCKS_ROOT
sudo chown $USER:$USER $APACHE_ROCKS_ROOT

echo "installing files into $APACHE_ROCKS_ROOT..."

# -----------------------------------------------
# include documents to serve in /srv/apache2/rocks/docs
mkdir $APACHE_DOCS_ROOT
cp -r frontend/{images,pages,scripts,styles} $APACHE_DOCS_ROOT

# -----------------------------------------------
# set up log files
mkdir -p $APACHE_LOGS_ROOT

# -----------------------------------------------
# include configuration file
PROJECT_GENERAL_CONF_ROOT=apache/general
mkdir -p $APACHE_CONFIG_ROOT
cp $PROJECT_GENERAL_CONF_ROOT/apache2-general.conf $APACHE_CONFIG_ROOT/httpd.conf

# -----------------------------------------------
# change permissions of server root files
chmod 755 $APACHE_ROCKS_ROOT/{.,conf,logs}
chown root:root $APACHE_ROCKS_ROOT/{.,conf,logs}


echo "(re)starting server..."

# -----------------------------------------------
# (re)start Apache server
source $PROJECT_GENERAL_CONF_ROOT/envvars-general.sh
echo $APACHE_LOG_DIR
sudo $APACHE_BIN -d $APACHE_CONFIG_ROOT -k $CMD
{
    [ $? -eq 0 ] &&
    {
      echo "...complete"
      echo "apache is serving site content on http://localhost:80"
      exit 0
    }
  } || {
    echo "error occurred while attempting to (re)start server"
    exit 1
  }

