#!/bin/sh
#
# Test the varnish VCL files, to check for syntax errors

if [ ! -f $1 ]; then
    echo "The file you specified does not exist!"
    echo "File: $1"
    exit 1
fi

tmpfile=$(mktemp)
trap 'rm -f $tmpfile' 0
varnishd -C -f $1 > $tmpfile
echo

if [ ! -s $tmpfile ]; then
    echo "ERROR: There are errors in the varnish configuration." >&2
    exit 1
else
    read -p "No Errors, do you want to restart Varnish? [y/n]: " ans;
    if [ $ans = 'y]' ]; then 
        echo -e "$(/etc/init.d/varnish restart)"
    fi
    exit 0
fi

