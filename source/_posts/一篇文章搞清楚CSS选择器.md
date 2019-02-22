---
title: 一篇文章搞清楚几个混淆的CSS选择器
date: 2019-02-21 16:10:30
tags: CSS
top:
---
>不知道大家是否和我一样,大部分时间对于CSS选择器我们只是在使用空格符和逗号符，而其他的一些符号直接被我们摒弃了，其实许多场景并不是用不到而是对于CSS选择器的不熟悉。所以这篇博客来回顾一些CSS选择器，来加深印象。

前提，我们先构建一个Html后面不再重复写：

```
// html
<div>
  <span>1</span>
  <span class='second'>2</span>
  <span>
      3
      <span>3-1</span>
  </span>
  <span>4</span>
</div>
```
### 空格符 与 > 
**空格符**，我们再熟悉不过了。`A B` 表示元素 A 的任意一个子元素 B 以及所有任意后代节点。
```
// css

div > span {
  border:1px solid red
}
```

效果如下：
![image](http://wx4.sinaimg.cn/mw690/a73bc6a1ly1g0ezl3xpyij209m02kjra.jpg)

**>符**，与空格符的区别是它只作用于直系后代。即 `A B` 表示元素 A 的任一元素 B，而没有B的后代节点。
举个例子：
```
// css

div > span {
  border:1px solid red
}
```

![image](http://wx2.sinaimg.cn/mw690/a73bc6a1ly1g0ezl496zvj209e02c0sn.jpg)


