---
title: ES6/7/8的串场复习
date: 2018-06-29 12:22:07
tags: ['javascript','ES6']
---
>平时写业务涉及到ES6/7/8常用的可能就常见的那几个，其他的不常用就忘记了，所以来专门记录一篇博客，以供经常翻阅之用。

### No.1 箭头函数
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
this.a=222
var obj = {
    a: 6,
    b: function () {
        console.log(this);  //obj
        console.log(this.a);//6
    },
    c: () => {
        console.log(this);  //{}
        console.log(this.a);//222
    },
    d: function () {
        setTimeout(() => {
            console.log(this);  //window
            console.log(this.a);//6
        }, 100);
    },
    e: function () {
        setTimeout(function () {
            console.log(this);  //timeout
            console.log(this.a);//undefined
        }, 100);
    }
}
```
4. 箭头函数不能当做Generator函数,不能使用yield关键字

----

### No.2 rest参数和拓展运算符
rest参数和拓展运算符虽然都是“...”的形态，但是两者的作用范围却截然不同

**rest参数**：Rest就是为解决传入的参数数量不一定,数组的相关的方法都可以用

```
function realSort(...rest) {
    console.log(rest.sort((a,b)=>a-b))
}
realSort(1,10,3) // [ 1, 3, 10 ]
```

**拓展运算符**：可以看作是rest参数的逆运算（展开数组操作），将数组转为字符串
```
console.log(1,2,...[4,5,6],7,8)  // 1 2 4 5 6 7 8
```
----

### No.3 字符串

**includes**
判断字符串是否有某值

```
console.log("abcd".includes('a'))   //true
console.log("abcd".includes('z'))   //false
```
**repeat**
复制字符串

```
console.log("abcd".repeat(3))   //abcdabcdabcd
```
----

### No.4 解构赋值
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
----

### No.5 Maps 和 WeakMaps
Maps 在 JavaScript 中是一个非常必须的数据结构.在ES6之前通过object实现哈希表,但是Es6引入maps结构后有一些优点
1. map可以使用任何类型的值作为key值，允许对值进行 set、get 和 search
2. object有原型，原型链上的键名有可能和对象上的键名产生冲突，但是map不会出现这种问题
3. map可以直接通过 .size计算键值对个数

```
let map2=new Map([['name','danny'],[true,false]])
map2.set('key','666')
console.log(map2.size)  //3
```

WeakMap 的 key 只能是 Object 类型。原始类型不能作为key值,在原生的WeakMap中,每个键对自己所引用对象的引用是 "弱引用",这意味着,如果没有其他引用和该键引用同一个对象,这个对象将会被当作垃圾回收，即不会发生内存泄漏问题。

```
var wm1 = new WeakMap();
wm1.set({}, 37);
```

----

### No.6 Promise函数
| 方法 |  结果|
|--|--|
| Promise.all |  返回一个promise对象，有一个reject就返回reject|
| Promise.race |  返回一个promise对象，回调最先解析出的结果|
| Promise.reject |  返回一个带有拒绝原因reason参数的Promise对象|
| Promise.resolve |  返回一个以给定值解析后的Promise对象|

----

### No.7 Generators生成器
就像 Promises 可以帮我们避免回调地狱，Generators 可以帮助我们让代码风格更整洁－－用同步的代码风格来写异步代码，它本质上是一个可以暂停计算并且可以随后返回表达式的值的函数。

```
function* gen(){
    yield 1
    yield 2
    yield 3
}

let g=gen()

console.log('gen:'+g.next().value)  //1
console.log('gen:'+g.next().value)  //2
console.log('gen:'+g.next().value)  //3
```

---

### No.8 Async Await
```
function getJSON(url) {
  return new Promise(function(resolve, reject) {
    request(url, function(error, response, body) {
      resolve(body);
    });
  });
}

async function main() {
  var data = await getJSON();
  console.log(data); // NOT undefined!
}
```
----

### No.9 类
JavaScript是没有类的概念的，ES6的类只不过是在原先的基础上坐了一层语法糖，看起来更像Java等语言的class
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

---
### No.10 模块
经常谈起模块化主要几种：AMD、CMD、CommonJS以及ES6模块，AMD具体实现是require.js，CMD是sea.js,但是随着前端的工程化发展，这两款在业务开发上已经渐渐退去热度。CommonJS在nodejs服务器段开发下经常被用到，至于ES6模块化也在ES6的普及下渐渐有了起色。

**CommonJS规范**：使用require引入模块，使用exports导出模块
```
//导出
exports.getInfo=function(){
    console.log('Hello World!')
}

//引入
var getInfo=require('./getInfo.js').getInfo
```
**ES6 module**:使用import引入模块,使用export导出模块
```
//导出
function getInfo(){
    console.log('Hello World!')
}

export getInfo
export default getInfo

//引入
import a from './getInfo.js'
import * as a from './getInfo.js' 
import { a } from './getInfo.js'
```
两者区别：require使用非常简单，它相当于module.exports的传送门，module.exports后面的内容是什么，require的结果就是什么，require运行的结果可以直接赋值给变量，但是import则非常严格，必须是放在文件的开头，而且格式确定，并且不会运行引入的模块，只是将其进行编译。

---

未完待续...



