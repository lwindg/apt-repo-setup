#!/bin/bash

APTKEY=%%APTKEY%%
BASEDIR=$(dirname $0)/../repo

pushd $BASEDIR > /dev/null

rm -fr dists
mkdir -p pool
mkdir -p dists/unstable/main/binary-amd64
mkdir -p dists/unstable/main/binary-i386
mkdir -p dists/unstable/main/binary-armhf
mkdir -p dists/unstable/main/source

apt-ftparchive generate ../conf/generate.conf
apt-ftparchive -c ../conf/release.conf release dists/unstable/ > dists/unstable/Release

gpg -abs --homedir ~/.gnupg --default-key $APTKEY -o dists/unstable/Release.gpg dists/unstable/Release

popd > /dev/null
