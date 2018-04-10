---
title: 原生JS实现小程序中类似vue的watch和computed方法
date: 2018-04-10 12:39:33
tags: 小程序
---
博主现在的工作项目是以小程序为主，所以就开始涉猎小程序这一块坑了。众所周知，小程序有点 miniVUE 的感觉，继承了vue很多的写法，入手还是很快的。同时小程序特有的一些api在微信生态里面用起来也是很爽歪歪～ 不过，用惯了vue就发现了小程序有很多功能是不支持的，这对于刚从vue转到小程序的我是何等的不习惯啊，所以这里面就打算首先来封装一下 watch 和 computed 两个方法。

### watch
watch监听的话，看过vue源码就应该知道这里要用到 Object.defineProperty 拦截判断了，上源码：
```
// vue watch 方法 监听值的变化
function watch(ctx, obj) {
  // obj是watch监听的一个对象集合 
  Object.keys(obj).forEach(key => {
    defineReactive(ctx.data, key, ctx.data[key], function (value) {
      // obj[key] 对应监听值的回调函数
      obj[key].call(ctx, value);
    })
  })
}

/**
 * 检测函数的变化
 * data 当前上下文的data，key 键名，val 键值，fn执行的回调函数
 */
function defineReactive(data, key, val, fn) {
  // 通过 Object.defineProperty进行set操作拦截
  Object.defineProperty(data, key, {
    configurable: true,
    enumerable: true,
    get: function () {
      return val
    }, 
    set: function (newVal) {
      if (newVal === val) return
      // 如果新值和老值不相同则返回回调函数fn
      fn && fn(newVal)
      val = newVal;
    }
  })
}
```

### computed
待续..
