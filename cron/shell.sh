#!/bin/sh

# delete temp files and folders
find /var/www/html/uploads/* -mmin +5 -type f -exec rm -fv {} \;
find /var/www/html/uploads/* -mmin +5 -type d -exec rm -rfv {} \;#