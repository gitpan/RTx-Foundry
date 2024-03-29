#!/bin/sh

case "$1" in
	start)
		if [ -x /usr/local/sbin/foundry-syncdata ]; then
			/usr/local/sbin/foundry-syncdata 60 &
			echo -n ' foundry-syncdata'
                else
                    if [ -x /usr/local/rt3/local/sbin/foundry-syncdata ]; then
			/usr/local/rt3/local/sbin/foundry-syncdata 60 &
			echo -n ' foundry-syncdata'
                    fi
		fi
		;;
	stop)
		if [ -f /tmp/foundry/syncdata.lock ]; then
			/bin/kill `cat /tmp/foundry/syncdata.lock` > /dev/null 2>&1 && echo -n ' foundry-syncdata'
		else
			echo "foundry-syncdata isn't running"
		fi
		;;
	*)
		echo ""
		echo "Usage: `basename $0` { start | stop }"
		echo ""
		exit 64
		;;
esac
