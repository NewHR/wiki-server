#!/usr/bin/env bash

yum remove docker \
           docker-common \
           container-selinux \
           docker-selinux \
           docker-engine

yum install -y yum-utils

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge

yum makecache fast
yum install -y docker-ce

systemctl start docker

yum install -y epel-release
yum install -y python-pip

yum upgrade -y python*

pip install --upgrade pip
pip install docker-compose

yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc-c++ make
yum install -y gcc perl-ExtUtils-MakeMaker

# Install the latest version of Git 2.x:
yum install -y http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
yum install -y git

curl --location "https://rpm.nodesource.com/setup_8.x" | bash -
yum install --nogpgcheck -y nodejs

cd /
mkdir /www
cd /www
git clone https://github.com/gollum/gollum.git
git clone git@gitlab.com:new.hr/wiki-base.git
git clone git@gitlab.com:new.hr/wiki-server.git server

cd server

docker build -t wiki .
#docker run -p 8375:80 -v `pwd`/db:/wiki -v `pwd`/gollum:/usr/local/bundle/gems/gollum-4.1.1 --name wiki -d wiki

docker-compose up
