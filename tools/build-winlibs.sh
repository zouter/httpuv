#!/bin/sh

# This script uses Vagrant to create an Ubuntu 12.04 VM, then
# cross-compiles Windows static libraries for libuv. The results
# should be checked into the rwinlib/libuv repo, and tagged with
# the libuv version number.

set -e

vagrant up
vagrant ssh -c /vagrant/_dobuild.sh
echo The build succeeded. Run "vagrant destroy" to clean up the VM.
