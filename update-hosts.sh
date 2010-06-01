#!/bin/sh
DIFFER=colordiff

cp hosts.winhelp hosts.winhelp.old

echo "Fetching current winhelp hosts..."
wget -O hosts.winhelp http://www.mvps.org/winhelp2002/hosts.txt

echo "Updating local hosts file..."
cp hosts.mine hosts

cat hosts.winhelp | grep -v 'localhost' | sed 's/127.0.0.1/127.0.0.0/g' >> hosts

echo "Done, here comes the diff"
$DIFFER hosts.winhelp.old hosts.winhelp
rm hosts.winhelp.old
