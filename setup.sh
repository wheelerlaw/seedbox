#!/usr/bin/env bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl build-essential autoconf screen g++ gcc libtool libcppunit-dev zlib1g-dev libssl-dev libncurses-dev libncursesw5-dev libcurl4-openssl-dev automake libxmlrpc-core-c3-dev pkg-config

cd /usr/local/src
curl -fsSL https://github.com/rakshasa/rtorrent/releases/download/v0.9.7/libtorrent-0.13.7.tar.gz -O
tar -xzvf libtorrent-0.13.7.tar.gz
rm libtorrent-0.13.7.tar.gz
cd libtorrent-0.13.7/
./autogen.sh
./configure
make -j2
make install
cd ..


curl -fsSL https://github.com/rakshasa/rtorrent/releases/download/v0.9.7/rtorrent-0.9.7.tar.gz -O
tar -xzvf rtorrent-0.9.7.tar.gz
rm rtorrent-0.9.7.tar.gz
cd rtorrent-0.9.7/
./autogen.sh
./configure --with-xmlrpc-c
make -j2
sudo make install
sudo ldconfig
cd ..
cp /vagrant/rtorrent.rc /etc/rtorrent.rc

cd /opt
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
git clone https://github.com/Flood-UI/flood.git
cd flood
cp /vagrant/config.js config.js
npm install --unsafe-perm
sudo npm run build

cat <<EOF | sudo tee /usr/local/bin/flood
#!/bin/sh
cd /opt/flood
exec node server/bin/start.js $@
EOF
sudo chmod +x /usr/local/bin/flood

cp /vagrant/rtorrent.service /etc/systemd/system && sudo systemctl start rtorrent.service
cp /vagrant/flood.service /etc/systemd/system && sudo systemctl start flood.service