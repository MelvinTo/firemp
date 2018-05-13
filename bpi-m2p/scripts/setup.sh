#!/bin/bash

set -e

CMDDIR=$(dirname $0)
BASEDIR=$(cd $CMDDIR/.. >/dev/null; pwd)

err() {
    echo "ERROR: $@" >&2
}

install_pkgs() {
    ( cd $BASEDIR/files/pkgs
    dpkg -i *.deb
    apt-get install -f
    )
}

patch_rootfs() {
    cpio -pdmv $BASEDIR/files/rootfs /
}

# ----------------------------------------------------------------------------
# MAIN
# ----------------------------------------------------------------------------

test $UID -eq 0

install_pkgs

patch_rootfs
