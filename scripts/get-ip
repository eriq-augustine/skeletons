#!/bin/sh

ipChecker='http://checkip.dyndns.com'
ip=`wget -qO - $ipChecker | sed 's/.*Current IP Address: \([^<]*\).*/\1/'`

echo $ip
