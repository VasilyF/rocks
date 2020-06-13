# envvars - default environment variables used in apache.conf

# this won't be correct after changing uid
unset HOME

export APACHE_CONFDIR=/srv/apache2/rocks
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_LOG_DIR=/srv/apache2/rocks/log
export LANG=C