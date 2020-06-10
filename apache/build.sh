#!/bin/bash

# -----------------------------------------------
# builds the application into a serviceable state
# on http://localhost/rocks.php:80
# -----------------------------------------------

APACHE_DOCS_ROOT="/var/www/rocks/"
APACHE_LOGS_ROOT="/var/log/apache2/"
APACHE_CONFIG_ROOT="/etc/apache2/"


# -----------------------------------------------
# copy all public files into docs root directory

# create directory if does not exist


# purge documents directory
sudo rm -rf $APACHE_DOCS_ROOT/*

# include content to be served
sudo cp rocks.php login.php $APACHE_DOCS_ROOT

# include resources
sudo cp -r scripts styles images common $APACHE_DOCS_ROOT

# -----------------------------------------------
# copy configuration files into config root
# directory and enable them

# -----------------------------------------------
# restart Apache server





