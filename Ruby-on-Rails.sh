#!/usr/bin/env bash

EXPECTED_ARGS=1
E_BADARGS=65

fancy_echo() {
  printf "\n%b\n" "$1"
}

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 version"
  exit $E_BADARGS
fi
# Setting Up MySQL
fancy_echo "Setting Up MySQL..."
  sudo apt-get -y install mysql-server mysql-client libmysqlclient-dev

# Installing Ruby
fancy_echo "Installing Ruby..."
  git config --global core.autocrlf false
  sudo apt-get update
  sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  rbenv install $1
  rbenv global $1
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# Configuring Git
fancy_echo "Configuring Git..."
  git config --global color.ui true
  echo -n "Name > "
  read name
  git config --global user.name "$name"
  echo -n "Email > "
  read email
  git config --global user.email "$email"
  ssh-keygen -t rsa -C "$email"

fancy_echo "Installing Bundler to install project-specific Ruby gems ..."
  gem install bundler --no-document --pre

fancy_echo "Configuring Bundler for faster, parallel gem installation ..."
  number_of_cores=$(nproc)
  bundle config --global jobs $((number_of_cores - 1))

# Installing Rails
fancy_echo "Installing Rails..."
  sudo add-apt-repository -y ppa:chris-lea/node.js
  sudo apt-get update
  sudo apt-get install -y nodejs
  gem install rails
  rbenv rehash
  gem update --system