#!/bin/bash

APACHE_DOCS_ROOT="/var/www/html"

# purge documents directory
sudo rm -rf $APACHE_DOCS_ROOT/*

# include content to be served
sudo cp rocks.php login.php $APACHE_DOCS_ROOT

# include resources
sudo cp -r scripts styles images common $APACHE_DOCS_ROOT


