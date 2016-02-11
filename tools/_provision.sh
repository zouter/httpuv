#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y --force-yes install \
	git \
	build-essential \
	automake \
	binutils-mingw-w64-x86-64 \
	gcc-mingw-w64-x86-64 \
	binutils-mingw-w64-i686 \
	gcc-mingw-w64-i686 \
	libtool \


# Removes an erroneous duplicate declaration that breaks the build.
# This was fixed in later versions of mingw-w64.
sed -i -e '/DWORD MprAdminConnectionRemoveQuarantine/ { N; N; N; N; d; }' /usr/i686-w64-mingw32/include/mprapi.h 
