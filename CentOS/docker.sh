#!/bin/bash

# install docker

yum -y install docker-io
service docker start
chkconfig docker on
