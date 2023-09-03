# Command Prompt
> windows默认shell(cmd.exe)

## 常用命令
> cmd内置命令默认后面接`/?` 查看命令的帮助

| 命令   | 描述    |
|--------------- | --------------- |
| **[dir](#dir)**    | 列出当前目录下的子目录 |
| **cls**    | 清屏   |
| **echo**    | 回显消息|
| **cd**    | 切换目录 |
| **[copy](#copy)** | 复制文件  |
| **[del](#del)**    | 删除文件 |
| **md/mkdir**    | 创建文件夹|
| **[rd](#rd)**    | 删除目录  |
| **[date](#date)**    | 查看当前日期  |
| **[mklink](#mklink)**    | 创建软链接(类似linux的`ln`命令 )  |
| **exit**    | 退出终端 |

### 命令说明

> 参数忽略大小写

#### dir

* `/A` 指定具体属性的文件显示
    ```cmd
    REM 显示隐藏文件
    dir /A:H
    REM 显示隐藏的文件夹
    dir /A:HD
    ```
* `/O` 排序
    ```cmd
    REM 按名称排序
    dir /O:N
    REM 按大小排序
    dir /O:S
    REM 按日期排序
    dir /O:D
    ```

#### copy
* TODO
#### del

* TODO 详细说明
* `/P` 删除前确认
* `/F` 强制删除
* `/S` 递归删除
* `/Q` 静默删除
* `/A` 按文件属性删除

### rd

* `/S` 递归删除
* `/Q` 静默删除

#### date

* `/T` 显示当前日期不提示输入新的日期 (默认`date`不带参数会提示输入新的日期)

#### mklink

> 参数默认都使用绝对路径

* 不带参数默认创建文件链接
    ```cmd
    REM 第一个参数是创建的链接，第二个参数是目标文件
    mklink /a/b/d /a/b/c
    ```
* TODO 详细说明
* `/D` 创建目录链接
* `/H` 创建硬链接
* `/J` 创建目录联接

## 其他命令

* TODO

## 批处理脚本

> .bat/.cmd文件

### 变量

```cmd
REM 定义变量
set a=1
REM 使用变量
echo %a%
```

### 条件

#### 数字

```cmd
REM == 相等
if 1 == 1 (echo 1)
REM neq 不相等
if 1 neq 2 (echo 1)
REM lss 小于
if 1 lss 2 (echo 1)
REM leq 小于等于
if 1 lss 1 (echo 1)
REM gtr 大于
if 2 gtr 1 (echo 1)
REM geq 大于等于
if 1 geq 1 (echo 1)
```

#### 字符串

> 匹配方式和数字的一样

```cmd
REM 忽略大小写匹配
if /i "a" == "A" (echo 1)
```

#### 文件

```cmd
REM 判断文件是否存在
if exist filename (echo 1)
REM 判断文件不存在
if not exist filename (echo 1)
```
#### 逻辑运算符

* TODO

### 结构控制

* TODO

#### if

* TODO

#### goto

* TODO

### 循环

* TODO

#### for

* TODO

#### while (使用goto实现)

* TODO

## 参考网站

* ss64 <https://ss64.com/nt/>   
