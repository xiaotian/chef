#!/usr/bin/env bash
command_exists () {
  command -v "$1" &> /dev/null ;
}

apt-get -y update
apt-get -y install git build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev

if ! command_exists ruby ; then
  echo 'Installing ruby from source ...'
  ruby_src=ruby-1.9.3-p194
  cd /tmp
  wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/${ruby_src}.tar.gz
  tar -xvzf ${ruby_src}.tar.gz
  cd ${ruby_src}/
  ./configure --prefix=/usr/local
  make
  make install
fi

if ! command_exists chef ; then
  echo 'Installing chef ...'
  gem install chef ruby-shadow --no-ri --no-rdoc
fi

