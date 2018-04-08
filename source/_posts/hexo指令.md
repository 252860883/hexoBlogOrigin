---
title: hexo常用指令
date: 2018-01-30 10:26:24
tags: hexo
---
### 常用的hexo指令
   
---   
#### init 新建一个网站
```js
$ hexo init [folder]
```

#### new 新建一篇文章
```js
$ hexo new [layout] <title>
```

#### publish 发表草稿
```js
$ hexo publish [layout] <filename>
```

#### generate 生成静态文件
```js
$ hexo generate
//简写
$ hexo g 
$ hexo g -d //文件生成立即部署
$ hexo g -w //监视文件变动
```

#### server 启动服务器 默认是4000
```js
$ hexo server
```

#### deploy 部署网站
```js
$ hexo deploy
//简写
$ hexo d
```

#### clean 清除缓存和已经生成的文件
```js
$ hexo clean
```