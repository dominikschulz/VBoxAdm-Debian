#
# Regular cron jobs for the vboxadm-ma package
#
0 4	* * *	root	[ -x /usr/lib/vboxadm/bin/mailarchive ] && /usr/lib/vboxadm/bin/mailarchive
