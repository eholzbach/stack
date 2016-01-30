#!/bin/sh
/usr/local/etc/rc.d/nginx stop
/root/letsencrypt/letsencrypt-auto certonly --keep-until-expiring -d ericholzbach.net,www.ericholzbach.net
/usr/local/etc/rc.d/nginx start
