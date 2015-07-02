#!/bin/bash

# install epel
wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/epel-release-7-5.noarch.rpm

rpm -ivh epel-release-7-5.noarch.rpm

# install docker
wget http://www.hop5.in/yum/el6/hop5.repo
mv hop5.repo /etc/yum.repos.d/
yum -y install docker-io
service docker start
chkconfig docker on
