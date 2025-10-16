# 软件安装方式

- 语言：[golang](#golang) • [java](#java) • [rust](#rust) • [zig](#zig)
- 服务：[nginx](#nginx) • [tomcat](#tomcat) • [mysql](#mysql)
- 其他：[nodejs](#nodejs) • [maven](#maven) • [drawio](#drawio)

---

## 手动安装软件版本管理目录层级

```bash
space
└── packages
    └── <package_name> # 包名
        ├── v1.0.0
        ├── v2.1.0
        ├── vx.x.x
        └── current -> v2.1.0 # 软链接到具体的版本
```

### 创建当前版本的软链接

> 使用相对路径创建软链接
>
> 设置环境变量时可以直接设置成 `space/packages/<package_name>/current`

Windows 下使用管理员权限打开 powershell

```powershell
# 切换到软件目录
cd packages/package_name/v2.1.0

# 创建软链接
New-Item -ItemType SymbolicLink -Path current -Target .\v2.1.0 -Force
```

Linux：

```bash
# 切换到软件目录
cd packages/package_name/v2.1.0

# 创建软链接
ln -sf v2.1.0 current
```

---

## golang

> [官网](https://golang.google.cn/) • [官网下载地址](https://golang.google.cn/dl/)

安装后手动配置 `GOROOT` 环境变量

### 关闭遥测

```bash
go telemetry off
```

## Java

> [OpenJDK 官网下载地址](https://jdk.java.net/archive/)

安装后手动配置 `JAVA_HOME` 环境变量

Windows 使用 scoop 包管理器安装：`scoop install openjdk17`

---

## Rust

> [官网](https://rust-lang.org/) • [官方安装文档](https://rust-lang.org/tools/install/)

---

## Zig

> [官网](https://ziglang.org/) • [官网下载地址](https://ziglang.org/download/)

Windows 使用 scoop 包管理器安装：`scoop install zig`

---

## Nginx

> [官网](https://nginx.org/) • [官网下载地址](https://nginx.org/en/download.html)

Windows 使用 scoop 包管理器安装：`scoop install nginx`

---

## Tomcat

> [官网](https://tomcat.apache.org/)

---

## Mysql

> [官网](https://www.mysql.com/)

---

## Nodejs

> [官网](https://nodejs.org/) • [官网下载地址](https://nodejs.org/zh-cn/download)

---

## Maven

---

> [官网](https://maven.apache.org/) • [官网下载地址](https://maven.apache.org/download.cgi)

---

## Drawio

> [官网](https://www.drawio.com/) • [GitHub 仓库](https://github.com/jgraph/drawio-desktop)

部署本地 drawio

### 1. 下载 drawio 源码

在 [Github 仓库](https://github.com/jgraph/drawio) 上查看最新的版本

```powershell
# 指定最新的 tag
git clone https://github.com/jgraph/drawio.git -b v28.2.5 --depth 1
```

### 2. 修改 web 源码为离线版

打开 `src/main/webapp/js/bootstrap.js` 找到 `urlParams` 变量定义处（这个函数是一个立即调用函数），一般就在最上面

在 `return result;` 上面添加 `result.offline = 1;`

```javascript
var urlParams = (function () {
  // ...

+  result.offline = 1;
  return result;
})();
```

### 3. 修改 nginx 配置文件

打开 `$ENV:NGINX_HOME/conf/nginx.conf`

在 server 块内添加，测试 drawio 下载在 `D:/drawio`

```nginx
http {
    # ...
    server {
        listen       80;
        server_name  localhost;

        location /drawio {
            alias D:/drawio/src/main/webapp;
            index  index.html index.htm;
        }

        # ...
    }
}
```
