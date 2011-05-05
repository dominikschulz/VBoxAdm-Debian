#!/bin/sh -e

### BEGIN INIT INFO
# Provides:          vboxadm-smtpproxy 
# Required-Start:    $network $remote_fs $syslog
# Required-Stop:     $network $remote_fs $syslog
# Should-Start:      mysql-server
# Should-Stop:       mysql-server 
# X-Start-Before:    $x-display-manager gdm kdm xdm wdm ldm sdm nodm
# X-Interactive:     true
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: VBoxAdm SMTP-Proxy Service 
### END INIT INFO

# Original version by Robert Leslie
# <rob@mars.org>, edited by iwj and cs
# Modified for openvpn by Alberto Gonzalez Iniesta <agi@inittab.org>
# Modified for restarting / starting / stopping single tunnels by Richard Mueller <mueller@teamix.net>
# Modified for VBoxAdm by Dominik Schulz <dominik.schulz@gauner.org>

. /lib/lsb/init-functions

test $DEBIAN_SCRIPT_DEBUG && set -v -x

DAEMON=/usr/sbin/vboxadm-sa
DESC="VBoxAdm SMTP-Proxy"
CONFIG_DIR=/etc/vboxadm
PIDFILE=/var/run/vboxadm/sa.pid
test -x $DAEMON || exit 0
test -d $CONFIG_DIR || exit 0

# Source defaults file; edit that file to configure this script.
if test -e /etc/default/vboxadm-sa ; then
  . /etc/default/vboxadm-sa
fi

start_proxy ()
{
    if [ "x$START_SMTPPROXY" = "xtrue" ]; then
        STATUS=0
        start-stop-daemon --start --quiet --oknodo \
            --pidfile $PIDFILE \
            --exec $DAEMON -- $OPTARGS \
            $DAEMONARG $STATUSARG || STATUS=1
        if [ $? != 0 ]; then
            echo "failed."
            exit 1
        else
            echo "ok."
            exit 0
        fi
    else
        echo "SMTP-Proxy disabled in /etc/default/vboxadm-sa"
        STATUS=0
    fi
}

stop_proxy ()
{
  if [ -e $PIDFILE ]; then
    kill `cat $PIDFILE` >/dev/null 2>&1 || true
    rm -f $PIDFILE
  fi
}

case "$1" in
start)
  log_daemon_msg "Starting $DESC"
  start_proxy
  log_end_msg ${STATUS:-0}
  ;;
stop)
  log_daemon_msg "Stopping $DESC"
  stop_proxy
  log_end_msg 0
  ;;

restart)
  $0 stop
  sleep 1
  $0 start
  ;;

force-reload)
  $0 stop
  sleep 1
  $0 start
  ;;

status)
  status_of_proc -p $PIDFILE vboxadm-smtpproxy "SMTP-Proxy" || GLOBAL_STATUS=1
  exit $GLOBAL_STATUS
  ;;
*)
  echo "Usage: $0 {start|stop|restart|force-reload|status}" >&2
  exit 1
  ;;
esac

exit 0

# vim:set ai sts=2 sw=2 tw=0:
