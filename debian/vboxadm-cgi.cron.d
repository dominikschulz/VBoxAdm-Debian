#
# Regular cron jobs for the vboxadm-cgi package
#
0 4	* * *	root	[ -x /usr/lib/vboxadm/bin/cleanup ] && /usr/lib/vboxadm/bin/cleanup
#0 4	* * *	root	[ -x /usr/lib/vboxadm/bin/dmarc ] && /usr/lib/vboxadm/bin/dmarc
