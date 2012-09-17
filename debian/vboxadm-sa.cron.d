#
# Regular cron jobs for the vboxadm-sa package
#
# Remove any spamassasin temp files which are older than one hour
0 *     * * *   vboxadm         find /tmp -name ".spamassassin.*" -mmin +60 -exec rm {} \; 
