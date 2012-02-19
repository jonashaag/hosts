#!/bin/sh

diffit() {
    echo $(diff $1 $2 | wc -l) lines changed
}

cp hosts.winhelp hosts.winhelp.old

echo Fetching current winhelp hosts...
wget -O hosts.winhelp http://www.mvps.org/winhelp2002/hosts.txt

echo Generating new hosts file...
rm hosts

echo Adding local hostname...
echo -n "127.0.0.1 localhost " >> hosts
hostname >> hosts
echo >> hosts

echo Updating local hosts file...
cat hosts.mine >> hosts

cat hosts.winhelp | tr -d '\r' | grep -v 'localhost' | sed 's/127.0.0.1/127.0.0.0/g' >> hosts

echo Done, here comes the diff

diffit hosts.winhelp.old hosts.winhelp

rm hosts.winhelp.old
sudo cp hosts /etc/hosts
