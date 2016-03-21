#!/bin/sh
#// -----------------------------------
#// Title: blockip.sh
#// Description: Add a valid IP
#//    address to iptables DROP list
#// Author: m00dimus@gmail.com
#// Version: 0.1_2016-03-18
#// -----------------------------------

valid_ip()
{
    local  ip=$1
    #// Regex from CommandlineFu
    result=`echo $ip | awk -F"\." ' $0 ~ /^([0-9]{1,3}\.){3}[0-9]{1,3}$/ && $1 <=255 && $2 <= 255 && $3 <= 255 && $4 <= 255 '`
    if [ -z "$result"]; then
    	return 1
    else
    	return 0
    fi
}

if valid_ip $1; then
   echo Blocking $1
   iptables -A INPUT -s $1 -j DROP
else
   echo Error: $1 appears to be invalid
fi
