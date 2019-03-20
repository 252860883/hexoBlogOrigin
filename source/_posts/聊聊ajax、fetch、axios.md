---
title: 聊聊ajax、fetch、axios
date: 2019-03-16 19:40:09
tags: javascript
top:
---

> 关于接口请求方法，近几年来有些变化，从一开始原生JS `AJAX` 到 JQuery 的 `$.ajax()`,再到 `Fetch` 和 vue 推荐的 `Axios`，但是否真正了解到每一个方法的优劣与使用场景了吗？

### AJAX
在前几年的时候，AJAX 可谓是前端一大考点啊，各路关于前端招聘的简介里，怎么也得让 AJAX 拥有姓名。AJAX（Asynchronous JavaScript and XML）异步的 Javascript 和 XML，核心就是使用 XMLHttpRequest 对象（对于旧版本浏览器例如 IE5、IE6则使用 ActiveXObject 对象）。
AJAX进行后端数据请求主要分一下几步：
1.创建 XMLHttpRequest 对象
2.进行 get 请求
3.利用 readyState 对象的 onreadystatechange 事件进行后续DOM或其他操作

具体实现见以下代码：
```
// 1.创建 XMLHttpRequest 对象

var xmlhttp;
if(window.XMLHttpRequest){
	//IE7+,Firefox,Chrome,Opera,Safari浏览器执行代码
	xmlhttp=new XMLHttpRequest();
}else{
	//IE6,IE5浏览器执行代码
	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}

// 2.进行 get 请求

xmlhttp.open("GET","/ajax/demo_get?t="+Math.random(),true);
xmlhttp.send();

// 3.readyState 
// XMLHttpRequest 对象通过 readyState 对象存储状态信息
// 当 readyState 状态改变时触发 onreadystatechange 事件。

xmlhttp.onreadystatechange=function(){
    if(xmlhttp.readyState==4 && xmlhttp.status==200){
        var responseData = xmlhttp.responseText;
    }
}
```

像上面这样使用 XMLHttpRequest 是来进行 ajax 请求是非常痛苦的，每做一个请求都要写这么长的代码！所以后来有许多的库都对其进行的封装，比如我们最常见的 JQuery。

### $.ajax()
JQuery ajax 是对原生XHR的封装，除此以外还增添了对JSONP的支持，相较于直接使用ajax的“长篇大论”，直接一个方法就可以搞定请求了:
```
$.ajax({
   type: 'POST',
   url: url,
   data: data,
   dataType: dataType,
   success: function () {},
   error: function () {}
});
```
虽然JQuery便捷了开发，但依旧受限于 XHR 的缺点。同时对基于事件的异步做的不好，而且如果我们只是使用 `$.ajax()` 这个方法还需要将整个 Jquery 文件引入。总之，如果不是在 JQuery 项目，建议还是不要使用此方法。

### Axios
自从尤大开始停止维护 vue-resource 并推荐大家使用 axios 之后，axios 逐渐被大家所认识。axios 是一个基于Promise 用于浏览器和 nodejs 的 HTTP 客户端，其实本质上底层也是通过 XHR 来实现的。尤大推荐自然有他的原因，axios 使用 Promise 封装，满足了现在的 ES6 的规范，同时还增加了很多的方法和功能，具体如下：
1.拦截请求和响应
2.转换请求和响应数据
3.支持 Promise API
4.提供了一些并发操作的方法
5.自动转换JSON数据
6.客户端支持防范XSRF
7.支持取消请求
8.从node.js发出http请求

```
<!-- 基础示例 -->

const axios = require('axios');

axios.get('/user?ID=12345')
  .then(function (response) {
    // handle success
    console.log(response);
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })

<!-- 拦截器 在请求或响应被 then 或 catch 处理前拦截它们-->

// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么
    return config;
  }, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
  });

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // 对响应数据做点什么
    return response;
  }, function (error) {
    // 对响应错误做点什么
    return Promise.reject(error);
  });

<!-- 并发处理 -->

axios.all([getRequest1(), getRequest2()])
  .then(axios.spread(function (acct, perms) {
    // Both requests are now complete
  }));

```

更多关于 axios 的使用方法，直接访问 [github](https://github.com/axios/axios) 查阅吧。

### Fetch
Fetch API 提供了一个获取资源的接口（包括跨域请求）。任何使用过 XMLHttpRequest 的人都能轻松上手，但新的API提供了更强大和灵活的功能集。

```
fetch(url, {
  method: "POST",
  body: JSON.stringify(data),
  headers: {
    "Content-Type": "application/json"
  },
  credentials: "same-origin"
}).then(function(response) {
  response.status     //=> number 100–599
  response.statusText //=> String
  response.headers    //=> Headers
  response.url        //=> String
  return response.text() // .text() 或者 .json() 可以获得响应体，并返回一个 promise 对象。
}, function(error) {
  error.message //=> String
})
```


