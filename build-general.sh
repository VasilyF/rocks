#!/bin/bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This build script is intended to be run
# on any UNIX/POSIX OS it places relevant
# files into /srv/apache2/
# execute from rocks/ repository root directory
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# -----------------------------------------------
# builds the application into a serviceable state
# on http://localhost:80
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
# declare environment variables
source apache/general/envvars-general.sh

if [ -f apache/general/envvars-local.sh ]; then
    source apache/general/envvars-local.sh
fi

# -----------------------------------------------
# determine the path to the apache2/httpd binary
if [ -z $APACHE_BIN ]; then
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
fi

if [ -z $APACHE_BIN ]; then
  echo "could not locate apache executable... "
  echo "you should either: "
  echo "1) explicitly provide the absolute path to the executable as the second argument"
  echo "ie. ./build-general.sh start /usr/sbin/apache2"
  echo "2) make sure that the executable can be found using the PATH variable"
  echo "3) insert the following into envvars-local.sh: (in apache/general)"
  echo "export APACHE_BIN=absolute/path/to/executable"
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

echo "purging $APACHE_SERVER_ROOT..."

# -----------------------------------------------
# purge /srv/apache2/rocks
sudo rm -rf $APACHE_SERVER_ROOT
sudo mkdir -p $APACHE_SERVER_ROOT
sudo chown $USER:$USER $APACHE_SERVER_ROOT

echo "installing files into $APACHE_SERVER_ROOT..."

# -----------------------------------------------
# include documents to serve in /srv/apache2/rocks/docs
mkdir $APACHE_DOCS_DIR
cp -r frontend/{images,pages,scripts,styles} $APACHE_DOCS_DIR

# -----------------------------------------------
# set up log files
mkdir -p $APACHE_LOGS_DIR

# -----------------------------------------------
# include configuration file
mkdir -p $APACHE_CONFIG_DIR
cp apache/general/apache2-general.conf $APACHE_CONFIG_DIR/httpd.conf

# -----------------------------------------------
# include runtime directories
[ ! -d $APACHE_RUN_DIR ] && mkdir -p $APACHE_RUN_DIR
[ ! -d $APACHE_LOCK_DIR ] && mkdir_chown $APACHE_RUN_USER $APACHE_LOCK_DIR


# -----------------------------------------------
# change permissions of server root files
chmod 755 $APACHE_SERVER_ROOT/{.,conf,logs}
chown root:root $APACHE_SERVER_ROOT/{.,conf,logs}


echo "(re)starting server..."

# -----------------------------------------------
# (re)start Apache server
sudo $APACHE_BIN -d $APACHE_CONFIG_DIR -k $CMD
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

