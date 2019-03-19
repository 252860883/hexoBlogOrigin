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
