#!/usr/bin/env bash
email="$1"
hostname="$2"
hostalias="$hostname"
keypath="$HOME/.ssh/${hostname}_rsa"
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
fi
ssh -T git@github.com
