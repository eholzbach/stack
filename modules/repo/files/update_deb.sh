#!/bin/sh
dpkg-scanpackages deb /dev/null | gzip -9c > deb/dists/jessie/main/binary-amd64/Packages.gz
dpkg-scanpackages deb /dev/null | gzip -9c > deb/dists/wheezy/main/binary-amd64/Packages.gz
