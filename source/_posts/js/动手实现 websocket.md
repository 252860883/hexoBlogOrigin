---
title: 动手实现前后端 websocket 通信
date: 2018-04-09 15:24:20
tags: [html5,nodejs]
---

毕设做的是一个校园约自习室网站，为了增强其互动性，我决定加入聊天系统来实现学生和管理员之间的联系。提到实时聊天，第一时间肯定联想到H5新加入的 websocket了。

> WebSocket是HTML5开始提供的一种浏览器与服务器间进行全双工通讯的网络技术。在WebSocket API中，浏览器和服务器只需要要做一个握手(handshaking)的动作，然后，浏览器和服务器之间就形成了一条快速通道。两者之间就直接可以数据互相传送。

### socket.io

后端是用nodejs写的，所以这里引入第三方插件 **socket.io**，来实现其功能。

 - **服务器端常用API**
 **socket.emit()**：向建立该连接的客户端发送消息
 **socket.on()**：监听客户端发送信息
 **io.to(socketid).emit()**：向指定客户端发送消息
 **io.sockets.socket(socketid).emit()**：向指定客户端发送消息，新版本用io.sockets.socket[socketid].emit() ，数组访问
**socket.broadcast.emit()**：向除去建立该连接的客户端的所有客户端广播
**io.sockets.emit()**：向所有客户端广播

 - **客户端常用API**
 **socket.emit()**：向服务端发送消息
 socket.on()：监听服务端发来的信息

 ### 项目源码分析
 
- **服务器端**
 ```
    var io = require('socket.io')(server);
    io.sockets.on('connection', function (socket) {
        // 收到发送者的消息
        socket.on('chatInfo', function (data) {
            chat.drawChatdb(data);
            // 当发送者发出消息，同时发出接收者接受消息的信号
            socket.broadcast.emit(data.saveId, data.content);
        });
    });
 ```

- **客户端**
  ```
    //引入socket.io
    import io from "socket.io-client";
    let serverPath = `${location.protocol}//${location.host}:4000`;
    const socket = io("http://localhost:4000");

    //接受对方发送的消息
    socket.on(self.userId, function(data) {
        data.stuId = data.sendId;
        self.chatLists.push(data);
        self.scrollToBottom();
    });

    //发送消息
    socket.emit("chatInfo", {
        sendId: this.userId.toString(),
        saveId: this.chatInfo.stuId.toString(),
        content: this.sendInfoNow,
        date: new Date().getTime()
    });

  ```

  ### 源码地址
  [点击进入项目源码](https://github.com/252860883/StudyRoom-System)



