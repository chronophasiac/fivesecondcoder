#!/usr/bin/env bash

update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
locale-gen en_US.UTF-8

# install packages with sudo for locale updates to take effect
sudo su -c "aptitude update;
aptitude -y install git-core libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libgdbm-dev ncurses-dev automake libffi-dev postgresql curl build-essential openssl libreadline6 zlib1g libssl-dev autoconf libc6-dev libtool bison pkg-config make postgresql-server-dev-all nodejs" - root

sudo su -c "bash /vagrant/bootstrap-postgresql.sh" - postgres
echo "local		all 	fivesecondcoder 			password" >> /etc/postgresql/9.1/main/pg_hba.conf
/etc/init.d/postgres restart

sudo su -c "\\curl -#L https://get.rvm.io | bash -s latest --rails;source ~/.profile" - vagrant
sudo su -c "cd /vagrant;bundle install;rake db:setup" - vagrant
