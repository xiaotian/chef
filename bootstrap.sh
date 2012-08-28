#!/usr/bin/env bash
command_exists () {
  command -v "$1" > /dev/null ;
}
if [ ! -f $NODE.json ]; then
  echo "$NODE.json doesn't exist, abort."
  exit
fi
apt-get -y update
apt-get -y install build-essential git-core ruby ruby-dev rubygems

# do not try to check chef-solo, as vagrant comes with one. just install it and let rubygems do the work
echo 'Installing chef ...'
gem install chef ruby-shadow --no-ri --no-rdoc

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
