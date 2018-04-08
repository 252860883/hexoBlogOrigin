---
layout: w
title: nodejs系列学习笔记（二）使用 superagent 与 cheerio 完成简单爬虫
date: 2018-02-12 10:27:58
tags: node.js
---
目的：当在浏览器中访问 http://localhost:3000/ 时，输出站酷（www.zcool.com.cn/） 主页的作品列表的标题，以 json 的形式。 

引入依赖  express、superagent、cheerio
superagent http方面的库，可以发起 get或者post的请求
cheerio 理解为 nodejs版的jquery，可以从网页中以css取数据，和jquery使用方式一样

核心代码：
```

app.get('/',function(req,res,next){
    superagent.get('http://www.zcool.com.cn/').end(function(err,sres){
        if(err){
            return err;
        }
        // sres.text存储着网页html的内容，
        // 将他传给cheerio.load之后就可以得到一个实现 jquery接口的变量
        var $=cheerio.load(sres.text);
        var items=[];
        $('.title-content').each(function(index,element){
            var $element = $(element);
            items.push({
                title:$element.attr('title'),
            });
        });

        res.send(items);
    });
})

```







