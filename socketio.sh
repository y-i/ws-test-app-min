#!/bin/sh

mkdir -p /ops/socketio
cd /ops/socketio

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs
npm install npm@latest -g
npm install -y
npm install --save socket.io express

NAME=$(hostname)

cat << EOF > index.js 
const app = require('express')();
const http = require('http').Server(app);
const io = require('socket.io')(http);

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){
  console.log('a user connected');
  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
    io.emit('chat message', '$NAME');
  });
});

http.listen(80, function(){
  console.log('listening on *:80');
});
EOF

node index.js &