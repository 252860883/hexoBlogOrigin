---
title: 聊聊JavaScript精度缺失这点事
date: 2018-09-13 11:51:37
tags: javascript
top:
---
>如果你是一个前端开发工程师的话，一定遇到过js语言上一些诡异的事情，比如某些运算的结果出现 1.999999999999 ，0.30000000000000004等等类似无限循环的小数，尽管和后端在接口字段上已经约束了保留以为小数。这个过程究竟发生了什么，导致出现如此丧心病狂的数字？下面来为你揭晓。

![image](http://p70gzm2sm.bkt.clouddn.com/WechatIMG421.png)
<center style="color:#aaa;">瞧！这诡异的js运算<center>

## IEEE754标准

大家都知道计算机只懂二进制，所以是不是在十进制转为二进制的时候出了差错呢？Javascript不像其他语言，数字都是由浮点型来表示，采用的是IEEE754运算标准。IEEE标准下的浮点数存储规定了两种浮点格式：单精度和双精度，包括三个基本的组成：符号位、指数、尾数，具体的分配如下表格所示：

| 类型 | 符号位 | 指数位 |尾数位|
|--|--|--|--|
| 单精度 | 1 [31]|8 [30-23] |23 [22-00] |
| 双精度 | 1 [63]|11 [62-52] |52 [51-00] |

**符号位**：直面意思，0表示正数，1表示负数。
**指数位**：因为指数位既需要能够表示正指数也需要能够表示负指数，为了能够做到这一点，需要将真实的指数数值加上一个偏移值获得用来存储的指数值。单精度浮点数情况下，这个偏移值是127。指数为-127（指数位全为0）和+128（指数位全为1）会被用来存储特殊的数值。对于双精度的浮点数，指数位的长度位11比特，偏移量位1023。
**尾数位**：尾数也被称为有效数位（significand）,决定浮点数的精确度。它由隐含的前导数位（小数点左边的部分）和小数部分（小数点右边的部分）组成。

## 二进制运算
还记得怎么十进制转二进制吗？根据前面关于指数位和尾数位的存储方式，我们对于小数和整数位分别有不同的计算方法：

![image](http://pefosasdn.bkt.clouddn.com/erjinzhi.png)
<center style="color:#aaa;">整数转二进制运算<center>

![image](http://p70gzm2sm.bkt.clouddn.com/abc.png)
<center style="color:#aaa;">小数转二进制运算<center>

所以动手来试试 0.1 转二进制是多少呢？

诶！ 经计算结果是 `0.0001100110011...(n个0011)`！无限循环的二进制！我们前面提到过，尾数位最多只能存放52位，所以误差就从这出现了！为了验证我们的猜想，分别计算出 0.1和0.2转为二进制后存储到的尾数位数据再进行二进制加法:

```
   00110011001100110011001100110011001100110011001100110011
+  00011001100110011001100110011001100110011001100110011001
-----------------------------------------------------------
   01001100110011001100110011001100110011001100110011001100

```
而这个结果正是`0.30000000000000004`转为二进制的尾数位。到现在我想，你应该已经明白JavaScript的精度缺失到底是如何造成的了。

### 避免精度缺失
由上可知，误差是不可避免的，但是为何只有Javascript存在这种问题呢？因为像c#的decimal和Java的BigDecimal等数字类型在其内部做了处理，而JavaScript是一种弱类型语言，并没有对计算精度做相应的处理。所有就需要我们在涉及到小数运算时做相应的处理了。

**粗暴解决法**
第一种就是粗暴解决法，那就是直接使用 `toFixed()` 把Number四舍五入为指定小数位数的数字。

```
let a=0.2+0.1
console.log(a)  //0.30000000000000004
console.log(a.toFixed(1))   //0.3

let b = 0.7-0.5
console.log(b)  //0.19999999999999996
console.log(b.toFixed(1))   //0.2
```


