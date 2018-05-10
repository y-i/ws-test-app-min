#!/bin/sh

mkdir -p /ops/socketio
cp -r client server.js /ops/socketio
cd /ops/socketio

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs
npm install npm@latest -g
npm install -y
npm install --save socket.io express

NAME=$(hostname)

sed -i -e "s/{{NAME}}/$NAME/" server.js

node server.js &