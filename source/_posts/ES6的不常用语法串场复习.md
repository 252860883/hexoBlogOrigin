---
title: ES6/7/8的串场复习
date: 2018-06-29 12:22:07
tags: ['javascript','ES6']
---
>平时写业务涉及到ES6/7/8常用的可能就那几个，其他的不常用就忘记了，所以来写一篇博客，以供经常翻阅之用。

### 箭头函数
 1. 匿名函数，不能作为构造函数，不能 new
 2. 没有arguments,可以使用rest参数
 ```
let a=(...arr)=>{
    console.log(arr)  // [1,2,3,4]
}
a(1,2,3,4)
```

3. 箭头函数不绑定this,会捕获上下文的this值
```
var obj = {
    a: 10,
    b: () => {
      console.log(this.a); // undefined
      console.log(this); // Window {postMessage: ƒ, blur: ƒ, focus: ƒ, close: ƒ, frames: Window, …}
    },
    c: function() {
      console.log(this.a); // 10
      console.log(this); // {a: 10, b: ƒ, c: ƒ}
    }
  }
```
4. 箭头函数不能当做Generator函数,不能使用yield关键字


### rest参数和拓展运算符
>rest参数和拓展运算符虽然都是“...”的形态，但是两者的作用范围却截然不同

rest参数：Rest就是为解决传入的参数数量不一定,数组的相关的方法都可以用
```
function realSort(...rest) {
    console.log(rest.sort((a,b)=>a-b))
}
realSort(1,10,3) // [ 1, 3, 10 ]
```

拓展运算符：可以看作是rest参数的逆运算（展开数组操作），将数组转为字符串
```
console.log(1,2,...[4,5,6],7,8)  // 1 2 4 5 6 7 8
```

### 字符串

**includes**
>判断字符串是否有某值
```
console.log("abcd".includes('a'))   //true
console.log("abcd".includes('z'))   //false
```
**repeat**
>复制字符串
```
console.log("abcd".repeat(3))   //abcdabcdabcd
```

### 解构赋值
```
let [b, c, d] = [1, 2, 3]
console.log(b, c, d)  //1,2,3
let { b1, c1 } = { b1: 1, c1: 2 }
console.log(b1, c1)   // 1,2
```
结构赋值在函数中的应用
```
function body({ eye, mouse } = { eye: 16, mouse: 20 }) {
    console.log(eye, mouse);
}
body({eye:10,mouse:10}) //10 10
body()  //16 20
body({eye:10})  //10 undefined
```

### 模块

```
//输出
module.exports=...

//接收
import "../a.js"
import {a} from "../a.js"
import * as additionUtil from 'math/addition';
```
 
### Maps 和 WeakMaps


### Promise

### Generators生成器

### Async Await

### 类
>JavaScript是没有类的概念的，ES6的类只不过是在原先的基础上坐了一层语法糖，看起来更像Java等语言的class
```
class Personal extends Person {
    constructor(name, age, gender, occupation, hobby) {
        super(name, age, gender);
        this.occupation = occupation;
        this.hobby = hobby;
    }

    incrementAge() {
        super.incrementAge();
        this.age += 20;
        console.log(this.age);
    }
}
```



