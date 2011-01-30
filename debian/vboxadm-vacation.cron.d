#
# Regular cron jobs for the vboxadm-vacation package
#
0 4	* * *	root	[ -x /usr/lib/vboxadm/bin/awl ] && /usr/lib/vboxadm/bin/awl
0 4	* * *	root	[ -x /usr/lib/vboxadm/bin/notify ] && /usr/lib/vboxadm/bin/notify
