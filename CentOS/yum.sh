#!/bin/bash
 
echo 'select mirrors:'
mirrors_163='1. 163'
mirrors_sohu='2. sohu'
url_163='http://mirrors.163.com/.help/CentOS6-Base-163.repo'
url_sohu='http://mirrors.sohu.com/help/CentOS-Base-sohu.repo'
echo  $mirrors_163
echo  $mirrors_sohu
 
read select
 
if [ 2 != $select ]
then
        url=$url_163
        fileName='CentOS6-Base-163.repo'
else
        url=$url_sohu
        fileName='CentOS-Base-sohu.repo'
fi
 
wget $url
 
if [ 0 -eq $? ]
then
        echo 'ok.'
else
        echo 'falid.'
        exit
fi
 
mkdir -p /etc/yum.repos.d/yum.bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/yum.bak/
mv ${fileName} /etc/yum.repos.d/CentOS-Base.repo
 
yum clean all
yum update & yum makecache

