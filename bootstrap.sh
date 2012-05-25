#!/usr/bin/env bash
command_exists () {
  command -v "$1" > /dev/null ;
}

apt-get -y update
apt-get -y install build-essential git-core ruby

if ! command_exists chef-solo ; then
  echo 'Installing chef ...'
  gem install chef ruby-shadow --no-ri --no-rdoc
else
  echo 'found chef-solo.'
fi

if [ ! -d "/var/chef" ]; then
  mkdir -p /var
  git clone git://github.com/xiaotian/chef.git /var/chef
  cd /var/chef
  git submodule init
  git submodule update
else
  echo '/var/chef exists, not cloning.'
fi

if [ $NODE ]; then
  echo 'Start cooking...'
  cd /var/chef
  chef-solo -c solo.rb -j $NODE.json
else
  echo 'no NODE specified, done.'
fi
