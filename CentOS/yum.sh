#!/bin/bash
 
echo 'select mirrors:'
mirrors_163='1. 163.'
mirrors_sohu='2. sohu.'
mirrors_other='3. Exit.'

url_163='http://mirrors.163.com/.help/CentOS6-Base-163.repo'
url_sohu='http://mirrors.sohu.com/help/CentOS-Base-sohu.repo'
echo  $mirrors_163
echo  $mirrors_sohu
echo  $mirrors_other
 
read select
 
if [ 1 == $select ]
then
        url=$url_163
        fileName='CentOS6-Base-163.repo'
elif [ 2 == $select ]
then
        url=$url_sohu
        fileName='CentOS-Base-sohu.repo'
else
	exit
fi

mkdir -p /etc/yum.repos.d/yum.bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/yum.bak/
 
wget $url
 
if [ 0 -eq $? ]
then
        echo 'ok.'
else
        echo 'falid.'
        exit
fi
 
mv ${fileName} /etc/yum.repos.d/CentOS-Base.repo
 
yum clean all
yum update & yum makecache

