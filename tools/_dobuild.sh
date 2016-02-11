#!/bin/bash

set -e

rm -rf libuv /vagrant/out
mkdir -p /vagrant/out/lib/i386
mkdir -p /vagrant/out/lib/x64
mkdir -p /vagrant/out/test/i386
mkdir -p /vagrant/out/test/x64

git clone https://github.com/libuv/libuv
cd libuv

git checkout v1.8.0

cp -R include /vagrant/out/


function fixup {
	# Create a header with some definitions missing mingw-w64 2.0.1
	# which is the version shipped with ubuntu 12.04
	# ref: http://sourceforge.net/p/mingw-w64/mailman/mingw-w64-public/thread/20120923143935.5105c12a7166e2afeff98385@gmail.com/
	cat > "src/win/missing.h" <<-EOF
	#include <ntddndis.h>
	#include <naptypes.h>
	typedef int MIB_TCP_STATE;
	EOF

	# patch src/win/util.c to include the generated header after winsock2.h include
	sed -i '/#include <winsock2.h>/a#include ".\/missing.h"' src/win/util.c
}

fixup

sh autogen.sh
./configure --disable-shared --enable-static --host=x86_64-w64-mingw32
make
make check || true
cp .libs/libuv.a /vagrant/out/lib/x64
cp test/run-tests.exe /vagrant/out/test/x64

git clean -xdf .
git checkout -- .

fixup

sh autogen.sh
./configure --disable-shared --enable-static --host=i686-w64-mingw32
make
make check || true
cp .libs/libuv.a /vagrant/out/lib/i386
cp test/run-tests.exe /vagrant/out/test/i386

echo
echo ===================================================================
echo  The build succeeded! \(Ignore errors about run-tests.exe failure.\)
echo  See ./out/ for build output.
echo ===================================================================
echo