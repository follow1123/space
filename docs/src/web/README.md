# HTML

* meta 描述该网站的信息

* a标签

  * target属性：

    * 默认_self在当前页面打开
    * _blank在新的页面打开

  * 锚链接

    * 标记
      * 实现：回到顶部功能

    ```html
    <a name="标记名></a>
    
    内容………………
    ……………………
             <!--跳到上面-->
    <a herf="#标记名"></a>
    ```

  * 功能性标签

  ```html
  <a href="mailto:邮箱地址"></a>
  ```

  

* video、aduio（视频、音频）
  * controls：控制功能
  * autoplay：自动播放

# CSS

* 渐变

  ```css
  background-color: #4158D0;
  background-image: linear-gradient(43deg, #4158D0 0%, #C850C0 46%, #FFCC70 100%);
  ```

  

# JavaScript

* 严格检查模式
  * 在javascript代码的第一行添加`'use strict';`开启严格检查模式，需要先选择ES6规范
* 长字符串使用``包裹
* 模板字符串长字符串类使用${变量名}引入变量的值不需要使用字符串拼接

```javascript
let str = `i = ${i}`;
```

* 集合遍历

```javascript
for(var index in list){
    //这里遍历出来的index为list的没得元素的下标
}
for(var el in list){
    //这遍历出来的el的list里面的元素
}
```

* 对象
* `'属性名' in  对象或类`判断该属性存不存在该对象内
* `对象['属性名']` 取该属性的值
* `Object.assign(对象1，对象2……)`, 将多个对象合并为一个对象

## 函数

* 可以传递任意的参数，也可以不传递参数
* `arguments`变量js自带对象，获取函数传递参数信息
* `...other(名字自定义)`，获取方法定义者未主动定义的参数（解决函数可以传入未定义的形参变量的问题）

```javascript
function sub(a, b, ...other) {
    console.log(`other.length = ${other.length}`);
    return a - b;
}
```

## BOM对象

# node

### 添加镜像仓库

* 打开用户目录下的.npmrc文，添加以下代码

```text
registry=https://registry.npm.taobao.org/
```
