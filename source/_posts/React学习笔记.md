---
title: React 学习笔记
date: 2018-02-24 23:45:58
tags: React
---

### 脚手架 create-react-app

#### 安装 
npm install -g create-react-app

#### 创建
create-react-app my-app
cd my-app

#### 运行
npm start (默认3000端口)

#### api开发请求代理
只需要在package.json中加入 
“proxy”:”http://localhost:3031/”

#### 打包文件路径不对问题
在package.json中加入  “homepage”：“.”

#### Webpack配置文件都是隐藏的
指令 npm run eject

如果报错，如下图，
￼
是因为git仓库有没有提交的文件，先commit了在运行指令就可以了

#### 安装 sass/less
npm install sass-loader node-sass --save-dev

安装后修改config -> webpack.config.dev.js 和 webpack.config.prod.js ，分别在css的loader配置里面修改两处：
一是 test: /\.css$/ 增加scss和sass；
二是use里面最后再加个loader，直接加 "sass-loader" 就可以了，也不用配置别的了。


#### 添加 ant-design
npm install antd babel-plugin-import --save-dev
配置，按需加载

 // 配置ant-design的按需加载
 plugins: [
      ['import', [{ libraryName: "antd", style: 'css' }]],
 ],

bundle-loader 路由懒加载


### JSX

const element = (
  <h1>
    Hello, {formatName(user)}!
  </h1>
);


### 渲染 DOM

ReactDOM.render(
  Element,
  document.getElementById('root')
);


### 组件 

class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}

<Welcome name=‘Du Honghui’   />

State

class Welcome extends React.Component {

constructor(props){
	super(props);
	// 初始化 state
	this.state={
		name:’Du Honghui’
	}
}

//当绑定到dom时执行
componentDidMount() {
	this.setState({
		name:’Du now’
	})    
}

render() {
    return <h1>Hello, {this.state.name}</h1>;
 }

}

### 生命周期钩子

componentDidMount()	组件插入到dom中的时候执行

componentWillUnmount()	组件被移除的时候执行

### 事件
书写 驼峰式

 function handleClick(e) {
    e.preventDefault();
    console.log('The link was clicked.');
 }

  return (
    < a href=" " onClick={handleClick}>
      Click me
    </ a>
  );

在组件中的时候需要添加 this.handleClick

处理回调函数的 this：
方法1: 在constructor中添加 bind 绑定 this

this.handleClick = this.handleClick.bind(this);

方法2: 使用属性初始化器(箭头函数)绑定回调函数
handleClick = () => {
    console.log('this is:', this);
  }