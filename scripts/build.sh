#!/bin/bash

# install dependencies for build

#apk update
apk --update add git
apk add gawk curl jq libuuid
apk add git zlib-dev automake autoconf build-base linux-headers musl-dev util-linux-dev libmnl-dev
apk add uuid-dev libmnl-dev gcc make curl git autoconf automake pkgconfig netcat-openbsd jq
apk add autoconf-archive lm_sensors nodejs python py-mysqldb py-yaml
apk add ssmtp mailutils apcupsd

# fetch netdata

git clone https://github.com/firehol/netdata.git /netdata.git
cd /netdata.git
TAG=$(</git-tag)
if [ ! -z "$TAG" ]; then
	echo "Checking out tag: $TAG"
	git checkout tags/$TAG
else
	echo "No tag, using master"
fi

# use the provided installer

./netdata-installer.sh --dont-wait --dont-start-it

# removed hack on 2017/1/3
#chown root:root /usr/libexec/netdata/plugins.d/apps.plugin
#chmod 4755 /usr/libexec/netdata/plugins.d/apps.plugin

# remove build dependencies

cd /
rm -rf /netdata.git

apk del zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autogen automake pkg-config
rm -rf /var/cache/misc/* /var/cache/apk/*

# symlink access log and error log to stdout/stderr

ln -sf /dev/stdout /var/log/netdata/access.log
ln -sf /dev/stdout /var/log/netdata/debug.log
ln -sf /dev/stderr /var/log/netdata/error.log
