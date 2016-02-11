#!/bin/sh

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

sh autogen.sh
./configure --disable-shared --enable-static --host=x86_64-w64-mingw32
make
make check || true
cp .libs/libuv.a /vagrant/out/lib/x64
cp test/run-tests.exe /vagrant/out/test/x64

git clean -xdf .

sh autogen.sh
./configure --disable-shared --enable-static --host=i686-w64-mingw32
make
make check || true
cp .libs/libuv.a /vagrant/out/lib/i386
cp test/run-tests.exe /vagrant/out/test/i386

