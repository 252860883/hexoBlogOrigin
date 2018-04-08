---
layout: w
title: nodejs系列学习笔记（三）使用 eventproxy 实现控制并发
date: 2018-02-12 10:27:58
tags: node.js
---
目的：输出站酷（http://www.zcool.com.cn/）主页每篇文章点击进入后页面的标题

引入依赖  express、superagent、cheerio、eventproxy
superagent http方面的库，可以发起 get或者post的请求
cheerio 理解为 nodejs版的jquery，可以从网页中以css取数据，和jquery使用方式一样
eventproxy 异步协作

核心代码：
```
superagent.get('http://www.zcool.com.cn/')
    .end(function (err, res) {
        if (err) {
            return console.log(err);
        }
        var urls = [];//存储所有文章的地址
        var $ = cheerio.load(res.text);

        $('.card-img-hover').each(function (idx, element) {
            var $element = $(element);
            // $element.attr('href') 本来的样子是 /topic/542acd7d5d28233425538b04
            // 我们用 url.resolve 来自动推断出完整 url，变成
            // https://cnodejs.org/topic/542acd7d5d28233425538b04 的形式
            var href = url.resolve(codeUrl, $element.attr('href'));
            urls.push(href);
        })

        var ep = eventproxy();
        // eventproxy控制并发
        urls.forEach(function(topicUrl){
            superagent.get(topicUrl).end(function(err,res){
                // 告诉ep当前的任务已经完成
                ep.emit('topic-html',[topicUrl,res.text])
            })                                                                                                                                                                                                                                                                                                                                                                                      
        })
        // eventproxy 的固定API在所有并发执行结束后执行
        ep.after('topic-html',urls.length,function(topics){
            // topics 是个数组，包含了 n 次 ep.emit('topic_html', pair) 中的那 n 个 pair
            topics=topics.map(function(topicPair){
                var topicUrl=topicPair[0];
                var topicHtml=topicPair[1];
                var $=cheerio.load(topicHtml);
                return({
                    title: $('h2').text().replace(/\s/g,"")
                })
            });
            console.log(topics);
        })
    })
```
总结：实质上 控制并发的功能是等到所有的异步执行结束以后再进行的一些操作。在ES6 promise 中通过 promise.all() 同理也可以实现该功能。






