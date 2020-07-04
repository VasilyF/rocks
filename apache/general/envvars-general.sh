# envvars - default environment variables used in apache.conf
# these variables are used in the build script as well as in
# the main apache config file (apache2-general.conf)

# this won't be correct after the server switches users
unset HOME

# $APACHE_SERVER_ROOT must be set in envvars-local.sh

export APACHE_DOCS_DIR=$APACHE_SERVER_ROOT/htdocs
export APACHE_LOGS_DIR=$APACHE_SERVER_ROOT/logs
export APACHE_CONFIG_DIR=$APACHE_SERVER_ROOT/conf
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2

export APACHE_PID_FILE=$APACHE_RUN_DIR/apache2.pid

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data

export LANG=C

# local environment variables should export:
# APACHE_BIN
# APACHE_MODULES_DIR

