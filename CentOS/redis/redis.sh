#!/bin/bash

#install gcc
yum install cpp
yum install binutils
yum install glibc
yum install glibc-kernheaders
yum install glibc-common
yum install glibc-devel
yum install gcc
yum install make

#install tcl
tar -zxvf tar/tcl8.6.1-src.tar.gz  -C /usr/local/  

export SRCDIR=`pwd` &&

cd /usr/local/tcl8.6.1/unix &&

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit) &&
make &&

sed -e "s#$SRCDIR/unix#/usr/lib#" \
    -e "s#$SRCDIR#/usr/include#"  \
    -i tclConfig.sh               &&

sed -e "s#$SRCDIR/unix/pkgs/tdbc1.0.3#/usr/lib/tdbc1.0.3#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.3/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/tdbc1.0.3/library#/usr/lib/tcl8.6#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.3#/usr/include#"            \
    -i pkgs/tdbc1.0.3/tdbcConfig.sh                        &&

sed -e "s#$SRCDIR/unix/pkgs/itcl4.0.3#/usr/lib/itcl4.0.3#" \
    -e "s#$SRCDIR/pkgs/itcl4.0.3/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/itcl4.0.3#/usr/include#"            \
    -i pkgs/itcl4.0.3/itclConfig.sh                        &&

unset SRCDIR

make install &&
make install-private-headers &&
ln -v -sf tclsh8.6 /usr/bin/tclsh &&
chmod -v 755 /usr/lib/libtcl8.6.so


#install redis
tar -zxvf tar/redis-3.0.2.tar.gz -C /usr/local/
cd /usr/local/
mv redis-3.0.2 redis && cd redis
make & make test & make install

echo "server: src/redis-server"
echo "client: src/redis-cli"
