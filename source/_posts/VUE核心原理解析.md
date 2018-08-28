---
title: VUE核心原理解析
date: 2018-08-22 16:50:05
tags: [vue,javascript]
top:
---
> 众所周知，VUE 是目前一款很流行专注于视图层、用于构建用户交互界面的响应式渐进框架。在使用 VUE 框架大力缩减了开发成本的同时，是否有想过VUE是如何实现双向绑定的？虚拟DOM到底为何物？传统的 DOM 操作又在何时进行？带着一系列的疑问，就开始这篇解析吧。

## 运行机制
![image](http://p70gzm2sm.bkt.clouddn.com/1606e7eaa2a664e8.jpg)

如上面流程图所示，大致流程：

1. new Vue() 创建 vue实例的过程，会调用 _init() 进行初始化操作，它会初始化生命周期、事件、 props、 methods、 data、 computed 与 watch 等。通过 Object.defineProperty 的 setter、getter 实现**响应式**以及**依赖**的收集。初始化后调用 $mount 挂载组件


2. 然后开始 complie 编译，分为三个阶段：parse、optimize、generate。**parse** 会用正则等方式解析 template 模板中的指令、class、style等数据，形成AST。**optimize** 的主要作用是标记 static 静态节点，在后续diff算法计算时会直接跳过静态节点，节省的比较时间，起到优化作用。**generate** 是将 AST 转化成 render function 字符串的过程，最终拿到 render function。

3. 接下来，由于之前在初始化的时候对 getter 和 setter 进行了设置，所以我们在读取对象的时候就会执行 getter 函数进行依赖收集，目的是将观察者 Watcher 对象放到当前的订阅者 Dep 的 subs 中。当给对象赋值的时候执行 setter 函数，setter 会通知之前设定的 Watcher 值发生变化需要更新视图。

4. 前面的 renderFunction 会转化为 VNode节点，在修改一个对象值的时候，会通过 setter -> Watcher -> update 的流程生成一个新的VNode。将新的 VNode 与旧的 VNode 一起传入 patch 进行比较，经过 diff 算法得出它们的「差异」。最后我们只需要将这些「差异」的对应 DOM 进行修改即可。

