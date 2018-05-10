const app = require('express')();
const http = require('http').Server(app);
const io = require('socket.io')(http);

app.get('/', function(req, res){
  res.sendFile(__dirname + '/client/index.html');
});

io.on('connection', function(socket){
  console.log('a user connected');
  const now = new Date();
  const time = `${`0${now.getHours()}`.slice(-2)}:${`0${now.getMinutes()}`.slice(-2)}:${`0${now.getSeconds()}`.slice(-2)}`
  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
    io.emit('chat message', '{{NAME}}');
    io.emit('chat message', time);
  });
});

http.listen(80, function(){
  console.log('listening on *:80');
});
