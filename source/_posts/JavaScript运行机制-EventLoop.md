---
title: JavaScript运行机制 EventLoop
date: 2019-03-01 16:42:57
tags: javascript
top:
---
### 单线程

相信了解 JavaScript 语言的人都知道，由于 JavaScript 脚本语言的特殊性，决定了它需要单线程运行。后来H5规范推出了 Web Worker 允许 JavaScript 可以创建多个线程，但是子线程仍然是完全受主线程的控制，所以本质上还是单线程的。

既然是单线程的，那我就有疑问了，我们平时经常进行 Ajax请求 、 setTimeout 等异步操作，浏览器会一直等待事件结束才执行下一个吗？如果一个请求的时间非常长，那这肯定是不行的。所以我们下面就来引入 任务队列 和 执行栈 的概念。

### 执行栈

首先来讲下JS执行栈，既然是栈嘛，那肯定采用的是后进先出的规则,主要用于存储在代码执行期间创建的所有执行上下文。
当 JavaScript 引擎首次读取脚本时，会创建一个全局执行上下文并将其推入当前的执行栈。每当发生一个函数调用，引擎都会为该函数创建一个新的执行上下文并将其推到当前执行栈的顶端。引擎会运行执行上下文在执行栈顶端的函数，当此函数运行完成后，其对应的执行上下文将会从执行栈中弹出，上下文控制权将移到当前执行栈的下一个执行上下文。我们来举个例子：
```
var a= 1;
function father(){
    console.log('enter father function');
    child();
    console.log('father function is over')
}
function child(){
    console.log('enter child function');
}
father();
```
上述函数的执行栈操作顺序如下图所示：
![image](http://wx3.sinaimg.cn/large/a73bc6a1ly1g0nh0euy5zj219s0ce75m.jpg)

理解了执行栈，我们可以知道我们脚本中的代码都会被依次执行，可是这依然没有解决我们一开始的疑惑，异步代码该怎么办呢？

### 任务队列

前面已经知道了，同步任务会被依次放到执行栈执行。那异步任务执行得到的结果回调函数会被放到任务队列中。当我们的执行栈中的所有同步任务执行完毕，引擎就会读取任务队列的事件，放入执行栈进行执行。任务队列是一个先进先出的数据结构，排在前面的事件会被优先处理。当然涉及到定时器任务时，只会在规定时间之后被执行。

除了异步任务，一些用户产生的事件比如 click 、 scroll 等只要涉及到了回调函数，都会统一放进任务队列等待主线程处理。

在任务队列中有一种特殊的任务队列叫做 **microtask（微任务）**，microtask 的特殊之处在于会在执行栈结束后优先其他队列执行。常见的 microtask 有：`Process.nextTick（Node独有）`、`Promise`、`Object.observe(废弃)`、`MutationObserver`。


### Event Loop
前面我们已经了解到了同步任务和异步任务在引擎中是如何执行的，而事件循环（Event Loop）呢就是在一遍遍的循环执行上面讲到的操作，每次循环发现新的函数，同步任务直接放入执行栈，异步任务的回调函数放入任务队列，再执行，周而复始。在 Event Loop 中，一次循环的执行称之为 tick， 在这个循环里执行的代码称作 task。




>参考:
>[如何理解js的执行上下文与执行栈](https://www.oecom.cn/understand-js-run-stack-and-world/)
>[一次搞懂Event loop](https://www.imooc.com/article/40020#)






