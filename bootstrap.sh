#!/usr/bin/env bash
command_exists () {
  command -v "$1" &> /dev/null ;
}

apt-get -y update
apt-get -y install git-core build-essential zlib1g-dev libssl-dev libreadline5-dev libyaml-dev

if ! command_exists ruby ; then
  echo 'Installing ruby from source ...'
  cd /tmp
  wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
  tar -xvzf ruby-1.9.3-p125.tar.gz
  cd ruby-1.9.3-p125/
  ./configure --prefix=/usr/local
  make
  make install
fi

if ! command_exists chef ; then
  echo 'Installing chef ...'
  # gem install chef ruby-shadow --no-ri --no-rdoc
fi

