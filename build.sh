#!/bin/bash

# in Docker, the USER variable is unset by default
# but some programs rely on it
export USER="$(whoami)"
export PATH="$HOME/bin:$PATH"

# Begin downloading sources
git clone https://github.com/quantum/esos.git esos_build
cd esos_build
git checkout $(git describe --tags)

# Fix build environment
autoconf
./configure
sudo make symlink

# Start building
make -j4 all > /tmp/bootstrap.out 2>&1
sudo ./chroot_build.sh -j4 -w -Orecurse > /tmp/chroot.out 2>&1
sudo rm work/chroot/tools
sudo make image
make pkg_dist
