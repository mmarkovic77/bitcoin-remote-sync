#!/bin/bash
BITCOIN_CORE_VERSION=v25.0
set -e;

cd ~
apt-get update -yqq
apt-get install -yqq build-essential libtool curl bison autotools-dev automake pkg-config bsdmainutils python3 libevent-dev libboost-dev libzmq3-dev git gettext-base
rm -rf bitcoin
git clone --branch $BITCOIN_CORE_VERSION --depth 1 --single-branch https://github.com/bitcoin/bitcoin.git
cd bitcoin 
cd depends 
make -j$(nproc) NO_QT=1 NO_QR=1 NO_SQLITE=1 NO_UPNP=1
cd .. 
./autogen.sh 
CONFIG_SITE=$PWD/depends/$(uname -m)-pc-linux-gnu/share/config.site ./configure --disable-tests --disable-bench --without-miniupnpc --with-incompatible-bdb --disable-man
make -j$(nproc)
make install
cd ~
envsubst < bitcoin.conf.template > .bitcoin/bitcoin.conf 
cat .bitcoin/bitcoin.conf
/usr/local/bin/bitcoind
