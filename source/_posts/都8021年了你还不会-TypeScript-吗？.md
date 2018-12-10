---
title: 都2018年了你还不会 TypeScript 吗？
date: 2018-12-03 14:52:46
tags: ['javascript','typescript']
top:
---
## 了解 TypeScript
>TypeScript 是 JavaScript 的一个超集，主要提供了类型系统和对 ES6 的支持。TS 增强了代码的可读性和可维护性。

在命令行中输入以下指令就可以在全局享用 TypeScript 语法啦！

```
npm install -g typescript
```

编译 TypeScript 也很简单 直接执行指令： `tsc 文件名` 。

### 对象类型
#### 基础数据类型
在 TypeScript 中有六种基础数据类型，其基本的定义格式为`let 变量名 : 数据类型 = 变量值`。这六种数据类型分别是：`boolean` `number` `string` `void` `undefined` `null`  需要注意，使用基础数据类型时一定要严格按照数据类型赋值，否则编译时会报错。

```
/**
 * boolean类型
 * new Boolean() 创造的对象不是布尔值而是一个布尔对象,下面这样写会报错
 * let is: boolean = new Boolean(2);  
 * boolean 是 JavaScript 中的基本类型，而 Boolean 是 JavaScript 中的构造函数。
 */

let isDone: boolean = false

/**
 * number类型
 */

let num_a: number = 6
let num_b: number = 0xffff
let num_c: number = NaN
// 二进制和八进制都会被编译成十进制
let num_d: number = 0o744
let num_e: number = 0b111

/**
 * 字符串
 */

let str_a: string = "Villion"
let str_b = `My name is ${str_a}.`


/**
 * 空值 Null Undefined
 */

let void_a: void = undefined
let und_b: undefined = undefined  // undefined 类型只能被赋值 undefined 
let null_c: null = null  // null 类型只能赋值 null 
```

#### 任意类型
和基础数据类型对立，可以赋任何类型的值。在任意值上访问任何属性都是允许的，也允许调用任何方法。
```
let any_a: any = "Dinosaur"
any_a.sayHello()
console.log(any_a.name)
```

变量如果在声明的时候，未指定其类型，那么它会被识别为任意值类型。
```
let any_b
// 等价于
let any_b: any
```
#### 类型推论
如果没有明确的指定类型，那么 TypeScript 会依照`类型推论`的规则推断出一个类型,但是编译阶段依然会进行报错。
```
let any_c = "string"
// 等价于
let any_c: string = "string"
```

#### 联合类型
联合类型就是一个对象可以是规定内的多种类型。在 TypeScript 中用 `|` 符号来分割定义的基础类型。当 TypeScript 不确定一个联合类型的变量到底是哪个类型的时候，只能访问此联合类型的所有类型里共有的属性或方法。变量在被赋值的时候，会根据类型推论的规则推断出一个类型。
```
let fix_a: string | number;
fix_a = "aaa";
fix_a = 1;
```

#### 数组类型 
在 TypeScript 中有很多定义方法，分别是`类型+[]`,`数组泛型`,`接口表示`,泛型和接口我们会在后面进行讲解，这里做简单了解即可。
```
// 表示方法一： 类型+[]
let arr_a: number[] = [1, 2, 3];
let arr_b: string[] = ['a', 'b', 'c'];
// 表示方法二：数组泛型
let arr_c: Array<number> = [1, 2, 3];
// 表示方法三：接口
interface nArray {
    [index: number]: number
}
let arr_d: nArray = [1, 2, 3, 4];
```
在赋值时，数组中的每个值都必须按照定义的类型赋值，否则会报错，如果类型不确定可以使用用 `any` 来表示。

我们常见的**类数组**，比如arguments等,在 TypeScript 都有对应的封装好的接口,如 IArguments, NodeList, HTMLCollection 等直接调用即可。
```
let args: IArguments = arguments;
```

#### 函数类型
函数定义的方式如下代码所示，需要注意传参以及函数输出都要对其进行类型定义，同时不能多输入或者少输入传参。
```
// 函数声明
function sum(a: number, b: number): number {
    return a + b;
}

// 函数表达式
let aSum = function (a: number, b: number): number {
    return a + b;
}
```

我们其实在很多情况下，实际传入的参数情况是不可控制的，那有什么办法可以解决这个问题吗？我们可以在参数的后面加一个 `?` 来表示这个参数是可选的，但是需注意，可选参数必须要在所有参数的最后位置。同时我们可以采用 ES6 的Rest参数来表示多余的传参。具体表示如下：
```
// 通过在参数名后面添加 ？ 来表示可选参数
function lessParams(a: number, b?: number) {
}
// 在参数尾以 ...变量名 形式表示更多参数
function moreParams(a: number, ...more) {
}
// 传递默认参数的方式如下：
function sum(a: number = 0, b: number = 0){
}
```
同时 函数同样可以使用 `|` 和 `any` 来定义不同的数据类型。

#### 类型断言
类型断言（Type Assertion）可以用来手动指定一个值的类型。之前提到过，当 TypeScript 不确定一个联合类型的变量到底是哪个类型的时候，我们只能访问此联合类型的所有类型里共有的属性或方法。但是有时候我们需要在不确定类型的时候就使用其中的一个属性或者方法。所以这时候就需要使用**类型断言**了。但是需注意：类型断言不是类型转换，断言成一个联合类型中不存在的类型是不允许的。
```
function getLength(something: string | number): number {
    if ((<string>something).length) {
        return (<string>something).length;
    } else {
        return something.toString().length;
    }
}
```

#### 内置对象
我们知道 JavaScript 中有很多的内置对象可供使用，那么在 TypeScript 中呢，可以直接当做定义好了的类型。
```
let in_b: Boolean = new Boolean(1);
let in_e: Error = new Error('Error occurred');
let in_d: Date = new Date();
let in_r: RegExp = /[a-z]/;
```
对于 DOM 和 BOM内置对象，Typescript 中对应了 `Document`,`HTMLElement`,`Event`,`NodeList`,`MouseEvent`等。举例：
```
let body: HTMLElement = document.body;
let allDiv: NodeList = document.querySelectorAll('div');
document.addEventListener('click', function(e: MouseEvent) {
  // Do something
});
```

### 接口
在面向对象语言中，接口（Interfaces）是一个很重要的概念，它是对行为的抽象，而具体如何行动需要由类（classes）去实现（implements）。在 TypeScriprt 中，类是一个非常灵活的概念，不仅可以对类的一部分进行抽象，还可以定义对象的形状。



> 学习整理自：https://legacy.gitbook.com/book/xcatliu/typescript-tutorial

