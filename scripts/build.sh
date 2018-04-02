#!/bin/bash

# install dependencies for build

apk update && apk add curl && yes | bash <(curl -Ss https://my-netdata.io/kickstart.sh) all

# removed hack on 2017/1/3
#chown root:root /usr/libexec/netdata/plugins.d/apps.plugin
#chmod 4755 /usr/libexec/netdata/plugins.d/apps.plugin

# remove build dependencies

cd /
rm -rf /netdata.git

rm -rf /var/cache/misc/* /var/cache/apk/*

# symlink access log and error log to stdout/stderr

ln -sf /dev/stdout /var/log/netdata/access.log
ln -sf /dev/stdout /var/log/netdata/debug.log
ln -sf /dev/stderr /var/log/netdata/error.log
