#!/usr/bin/env bash

# install packages
aptitude update
aptitude -y install git-core libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libgdbm-dev ncurses-dev automake libffi-dev postgresql curl build-essential openssl libreadline6 zlib1g libssl-dev autoconf libc6-dev libtool bison pkg-config make postgresql-server-dev-all nodejs

# setup Postgresql
pg_hba_path="/etc/postgresql/9.1/main/pg_hba.conf"
pg_auth="local		all 	fivesecondcoder 			password"
if [ "$(grep "$pg_auth" $pg_hba_path)" != "$pg_auth" ]; then
	create_role="psql <<- EOF
	create role fivesecondcoder with createdb login password 'mNiVc3t3dyneTD8C';
	EOF"
	sudo su -c "$create_role" - postgres 
	echo "$pg_auth" >> $pg_hba_path
	/etc/init.d/postgresql restart
fi

# install RVM
if [ "$(sudo su -c 'type rvm | head -1' - vagrant)" == "rvm is a function" ]; then
	sudo su -c "rvm get head" - vagrant
else
	sudo su -c "\\curl -L https://get.rvm.io | bash -s latest --rails;source ~/.profile" - vagrant
fi

# install gems and finalize environment
sudo su -c "cd /vagrant;bundle install;rake db:drop;rake db:setup" - vagrant
