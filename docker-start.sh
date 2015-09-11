#!/bin/bash
set -e

email="$GITHUB_EMAIL"
hostname="github.com"
hostalias="$hostname"
keypath="$HOME/.ssh/${hostname}_rsa"
echo $keypath
if [ $email -eq "" ]; then
  echo "Specified your GITHUB_EMAIL in environements variables"
fi
if [ ! -f $keypath ]; then
  ssh-keygen -t rsa -C $email -f $keypath -q -N ""
  if [ $? -eq 0 ]; then
    cat >> ~/.ssh/config <<EOF
    Host $hostalias
      Hostname $hostname
      User git
      StrictHostKeyChecking no
    IdentitiesOnly yes
      IdentityFile $keypath
EOF
  fi
  echo "Import the key in github : "
  cat ~/.ssh/github.com_rsa.pub
  exit;
fi

ssh -T git@github.com &
# PROD
if [ ! -f "." ]; then
  git clone $DEPO_LARAVEL .
  composer install
fi
service nginx start &
service php5-fpm restart
tail -f /var/log/nginx/access.log &
tail -f /var/log/nginx/error.log

# cp .env.example .env
# php artisan ide-helper:generate
# composer install
