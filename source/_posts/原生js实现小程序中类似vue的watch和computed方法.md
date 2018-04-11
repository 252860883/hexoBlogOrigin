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
      // 如果新值和老值不相同则执行回调函数fn
      fn && fn(newVal)
      val = newVal;
    }
  })
}
```

### computed
computed的话，原理和watch操作类似，不同的是需要在数值变化的时候添加执行相应的一些操作，上源码：
```
// computed 函数
function computed(ctx, obj) {
  let computedKeys = Object.keys(obj)//computed 对象集合
  let computedFn = [];//computedFn存储computed计算操作
  let computedObj = computedKeys.reduce((total, next) => {
    computedFn.push(function () {
      ctx.setData({ [next]: obj[next].call(ctx) })
    })
    total[next] = obj[next].call(ctx);
    return total
  }, {})
  // 首次加载先设置一次
  ctx.setData(computedObj)
  // 绑定数据变化时，动态computed
  let dataKeys = Object.keys(ctx.data)
  dataKeys.forEach(dataKey => {
    defineReactive(ctx.data, dataKey, ctx.data[dataKey], false, computedFn)
  })
}

/**
 * 检测函数的变化
 * data 当前上下文的data，key 键名，val 键值，fn 回调函数
 */
function defineReactive(data, key, val, fn, computedFn) {
  // 通过 Object.defineProperty进行set操作拦截
  let subs = [];
  Object.defineProperty(data, key, {
    configurable: true,
    enumerable: true,
    get: function () {
      if (data.$target) {
        subs.push(data.$target)
      }
      return val
    },
    set: function (newVal) {
      if (newVal === val) return
      // 如果新值和老值不相同则返回回调函数 fn
      fn && fn(newVal)
      val = newVal;
      if (computedFn.length) {
        // 执行 computed的更新设置值
        computedFn.forEach(sub => sub());
      }
    },
  })
}
```
