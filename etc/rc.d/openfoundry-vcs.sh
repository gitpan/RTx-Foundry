#!/bin/sh

case "$1" in
	start)
		if [ -x /usr/local/sbin/openfoundry-cvs2svn ]; then
			/usr/local/sbin/openfoundry-cvs2svn 60 &
			echo -n ' openfoundry-cvs2svn'
		fi
		if [ -x /usr/local/sbin/openfoundry-syncdata ]; then
			/usr/local/sbin/openfoundry-syncdata 60 &
			echo -n ' openfoundry-syncdata'
		fi
		;;
	stop)
		if [ -f /tmp/openfoundry/cvs2svn.lock ]; then
			/bin/kill `cat /tmp/openfoundry/cvs2svn.lock` > /dev/null 2>&1 && echo -n ' openfoundry-cvs2svn'
		else
			echo "openfoundry-cvs2svn isn't running"
		fi
		if [ -f /tmp/openfoundry/syncdata.lock ]; then
			/bin/kill `cat /tmp/openfoundry/syncdata.lock` > /dev/null 2>&1 && echo -n ' openfoundry-syncdata'
		else
			echo "openfoundry-syncdata isn't running"
		fi
		;;
	*)
		echo ""
		echo "Usage: `basename $0` { start | stop }"
		echo ""
		exit 64
		;;
esac
