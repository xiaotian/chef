#!/usr/bin/env bash
command_exists () {
  command -v "$1" > /dev/null ;
}

apt-get -y update
apt-get -y install git-core build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev

if ! command_exists ruby ; then
  # echo 'Installing ruby from source ...'
  # ruby_src=ruby-1.9.3-p194
  # cd /tmp
  # wget -O ${ruby_src}.tar.gz ftp://ftp.ruby-lang.org/pub/ruby/1.9/${ruby_src}.tar.gz
  # tar -xvzf ${ruby_src}.tar.gz
  # cd ${ruby_src}/
  # ./configure --prefix=/usr/local
  # make
  # make install
  apt-get -y install ruby
else
  echo 'found ruby.'
fi

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
