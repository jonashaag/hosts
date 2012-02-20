#!/bin/sh

diffit() {
    echo $(diff $1 $2 | wc -l) lines changed
}

rm hosts
cp hosts.winhelp hosts.winhelp.old

echo Fetching current winhelp hosts...
wget -O hosts.winhelp http://winhelp2002.mvps.org/hosts.txt

echo Updating local hosts file...
echo 127.0.0.1 localhost $(hostname) >> hosts
echo >> hosts
if [ -e hosts.private ]; then
  cat hosts.private >> hosts
fi
cat hosts.mine >> hosts

cat hosts.winhelp | tr -d '\r' | grep -v 'localhost' | sed 's/127.0.0.1/127.0.0.0/g' >> hosts

echo Done, here comes the diff

diffit hosts.winhelp.old hosts.winhelp

rm hosts.winhelp.old
sudo cp hosts /etc/hosts
