#!/bin/bash

#install gcc
yum -y install cpp
yum -y install binutils
yum -y install glibc
yum -y install glibc-kernheaders
yum -y install glibc-common
yum -y install glibc-devel
yum -y install gcc
yum -y install make

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
cd -
tar -zxvf tar/redis-3.0.2.tar.gz -C /usr/local/
cd /usr/local/
mv redis-3.0.2 redis && cd redis
make & make test & make install

# 将src下的可执行命令全部移动到/usr/local/redis/bin/目录下
mkdir bin & mkdir etc
cd ./src
mv mkreleasehdr.sh redis-benchmark redis-check-aof redis-check-dump redis-cli redis-sentinel redis-server /usr/local/redis/bin

# 修改配置文件路径
cd ..
mv redis.conf /usr/local/redis/etc/
cp /usr/local/redis/etc/redis.conf /usr/local/redis/etc/redis.conf.bak
# 修改redis为后台运行
filepath=/usr/local/redis/etc/redis.conf

sed -i 's/daemonize no/daemonize yes/g'  "$filepath"


echo "启动redis server命令: cd /usr/local/redis/bin/ & ./redis-server /usr/local/redis/etc/redis.conf"
echo "注意：开启redis服务需要指定配置文件，如不指定配置文件则加载默认配置文件。"
echo "启动redis client命令: cd /usr/local/redis/bin/ & ./redis-cli /usr/local/redis/etc/redis.conf"
