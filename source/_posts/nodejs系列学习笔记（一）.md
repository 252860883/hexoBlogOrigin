---
title: nodejs系列学习笔记（一） express框架实现简单的应用
date: 2018-02-11
tags: node.js
---

首先安装express框架的依赖包，直接就安装在项目的 node_modules 目录下。这里使用了淘宝的cnpm镜像，下载速度更快一些。
```js
    cnpm install express
```
目录下出现 express 的文件夹，即代表安装成功。

新建一个 app.js 文件
```
touch app.js
```

写入代码
```
// 这句的意思就是引入 `express` 模块，并将它赋予 `express` 这个变量等待使用。

var express = require('express');

// 调用 express 实例，它是一个函数，不带参数调用时，会返回一个 express 实例，将这个变量赋予 app 变量。

var app = express();

// app 本身有很多方法，其中包括最常用的 get、post、put/patch、delete，
// 在这里我们调用其中的 get 方法，为我们的 `/` 路径指定一个 handler 函数。
// 这个 handler 函数会接收 req 和 res 两个对象，他们分别是请求的 request 和 response。
// request 中包含了浏览器传来的各种信息，比如 query 啊，body 啊，headers 啊之类的，都可以通过 req 对象访问到。
// res 对象，我们一般不从里面取信息，而是通过它来定制我们向浏览器输出的信息，
// 比如 header 信息，比如想要向浏览器输出的内容。这里我们调用了它的 #send 方法，向浏览器输出一个字符串。

app.get('/', function (req, res) {
  res.send('Hello World');
});

// 定义好我们 app 的行为之后，让它监听本地的 3000 端口。这里的第二个函数是个回调函数，会在 listen 动作成功后执行，
// 我们这里执行了一个命令行输出操作，告诉我们监听动作已完成。

app.listen(3000, function () {
  console.log('app is listening at port 3000');
});
```

下面是一个从地址里面获取参数值的代码：
```
var express = require('express');
var utility = require('utility');

var app = express();

app.get('/', function (req, res) {
    var q = req.query.q;
    // md5转义
    // utility库定义了许多复杂的辅助函数
    var md5Value = utility.md5(q);
    res.send(md5Value);
})

app.listen(3000, function (req, res) {
    console.log('app is running at port 3000');
})
```

如果地址栏里面没有 q的话则会报错。

#### 补充 
端口的作用：通过端口来区分出同一电脑内不同应用或者进程，从而实现一条物理网线(通过分组交换技术-比如internet)同时链接多个程序

端口号是一个 16位的 uint, 所以其范围为 1 to 65535 (对TCP来说, port 0 被保留，不能被使用. 对于UDP来说, source端的端口号是可选的， 为0时表示无端口).





