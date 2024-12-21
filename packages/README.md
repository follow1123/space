* [JDK](#jdk)
* [Maven](#maven)
* [Tomcat](#tomcat)
* [MySQL](#mysql)
* [版本管理结构](#版本管理结构)

### JDK

> 使用 `powershell` 安装

#### scoop 安装

```powershell
scoop install openjdk17
```

#### 手动安装

> 安装 OpenJDK，[官网下载地址](https://jdk.java.net/archive/)

设置当前版本

```powershell
# 如果已经设置当前的版本，需要先删除
rm $Env:USERPROFILE\space\packages\jdk\current

# 设置当前版本软链接，<jdk_version> 需要手动设置
Start-Process `
    -FilePath "cmd" ` -ArgumentList "/c", `
    "mklink","/d", `
    "$Env:USERPROFILE\space\packages\jdk\current", `
    "$Env:USERPROFILE\space\packages\jdk\<jdk_version>" `
    -Verb RunAs
```

设置环境变量

```powershell
# 配置 JAVA_HOME 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "JAVA_HOME", "$Env:USERPROFILE\space\packages\jdk\current", "User" `
)

# 配置 PATH 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "PATH", `
    "$([System.Environment]::GetEnvironmentVariable('PATH', 'USER'))$Env:JAVA_HOME\bin", `
    "User" `
)
```

### Maven

> 使用 `powershell` 安装

#### scoop 安装

```powershell
scoop install maven
```

#### 手动安装

```powershell
# 配置 MAVEN_HOME 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "MAVEN_HOME", "$Env:USERPROFILE\space\packages\maven\current", "User" `
)

# 配置 PATH 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "PATH", `
    "$([System.Environment]::GetEnvironmentVariable('PATH', 'USER'))$Env:MAVEN_HOME\bin", `
    "User" `
)
```

### Tomcat

> 使用 `powershell` 安装

#### scoop 安装

```powershell
scoop install tomcat
```

#### 手动安装

```powershell
# 配置 CATALINA_HOME 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "CATALINA_HOME", "$Env:USERPROFILE\space\packages\tomcat\current", "User" `
)

# 配置 PATH 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "PATH", `
    "$([System.Environment]::GetEnvironmentVariable('PATH', 'USER'))$Env:CATALINA_HOME\bin", `
    "User" `
)
```

### MySQL

#### 手动安装

> 安装 MySQL `5.7.30`

解压 MySQL 压缩包文件到 `~/space/packages/mysql/5.7.30`，以**管理员权限**打开 `cmd` 并执行以下命令：

```cmd
rem 设置解压后的 MySQL 目录
set MYSQL_HOME=%USERPROFILE%\space\packages\mysql\5.7.30

rem 切换到 MySQL 目录
cd %MYSQL_HOME%

rem 设置 UTF-8 编码
chcp 65001

rem 添加配置文件
rem 如果需要修改 data 目录位置，重新指定 datadir 属性即可
(
echo [mysql]
echo # 设置mysql客户端默认字符集
echo default-character-set=utf8
echo [mysqld]
echo #设置3306端口
echo port=3306
echo # 设置mysql的安装目录
echo basedir=%MYSQL_HOME%
echo # 设置mysql数据库的数据的存放目录
echo datadir=%MYSQL_HOME%\data
echo # 允许最大连接数
echo max_connections=200
echo # 服务端使用的字符集默认为8比特编码的latin1字符集
echo character-set-server=utf8
echo # 创建新表时将使用的默认存储引擎
echo default-storage-engine=INNODB
) > my.ini

rem 安装 MySQL 服务
rem
rem 如果需要安装多个版本的 MySQL
rem     mysqld install "<server_name>" --defaults-file="%MYSQL_HOME%\my.ini"
rem
rem 如果需要删除某个 MySQL 服务，不会删除数据文件，只删除服务
rem     mysqld remove "<server_name>"
.\bin\mysqld.exe install 

rem 初始化 MySQL 相关文件
rem 这行命令执行完成后检查 MySQL 目录下有没有新建 data 目录
.\bin\mysqld.exe --initialize-insecure --user=mysql

rem 启动 mysql 服务
rem 如果指定了服务名，mysql 替换成上面的 <server_name>
net start mysql

rem 进入 MySQL 命令行，提示要输入密码，直接回车
.\bin\mysql.exe -uroot -p

rem 修改密码
update mysql.user set authentication_string=password('<password>') where user='root' and host='localhost';

rem 刷新权限
flush privileges;

rem 退出MySQL
exit

rem 重启服务，安装完成
net stop mysql
net start mysql
```

打开 `powershell` 设置**当前版本**并配置 PATH 环境变量

```powershell
# 如果已经设置当前的版本，需要先删除
rm $Env:USERPROFILE\space\packages\mysql\current

# 设置当前版本软链接，设置为8.0.33
Start-Process `
    -FilePath "cmd" ` -ArgumentList "/c", `
    "mklink","/d", `
    "$Env:USERPROFILE\space\packages\mysql\current", `
    "$Env:USERPROFILE\space\packages\mysql\8.0.33" `
    -Verb RunAs

# 配置 PATH 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "PATH", `
    "$([System.Environment]::GetEnvironmentVariable('PATH', 'USER'))$Env:USERPROFILE\space\packages\mysql\current\bin", `
    "User" `
)
```

<details>
    <summary>安装 MySQL <code>8.0.33</code></summary>
解压 MySQL 压缩包文件到 <code>~/space/packages/mysql/8.0.33</code>，以<strong>管理员权限</strong>打开 <code>cmd</code> 并执行以下命令：

```cmd
rem 设置解压后的 MySQL 目录
set MYSQL_HOME=%USERPROFILE%\space\packages\mysql\8.0.33

rem 切换到 MySQL 目录
cd %MYSQL_HOME%

rem 设置 UTF-8 编码
chcp 65001

rem 添加配置文件
rem 如果需要修改 data 目录位置，重新指定 datadir 属性即可
(
echo [mysqld]
echo #设置3306端口
echo port = 3306
echo # 设置mysql的安装目录
echo basedir=%MYSQL_HOME%
echo # 设置mysql数据库的数据的存放目录
echo datadir=%MYSQL_HOME%\data
) > my.ini

rem 安装 MySQL 服务
rem
rem 如果需要安装多个版本的 MySQL
rem     mysqld install "<server_name>" --defaults-file="%MYSQL_HOME%\my.ini"
rem
rem 如果需要删除某个 MySQL 服务，不会删除数据文件，只删除服务
rem     mysqld remove "<server_name>"
.\bin\mysqld.exe install 

rem 初始化 MySQL 相关文件
rem 这行命令执行完成后检查 MySQL 目录下有没有新建 data 目录
.\bin\mysqld.exe --initialize-insecure --user=mysql

rem 启动 mysql 服务
rem 如果指定了服务名，mysql 替换成上面的 <server_name>
net start mysql

rem 进入 MySQL 命令行，提示要输入密码，直接回车
.\bin\mysql.exe -uroot -p

rem 修改密码
use mysql;
alter user root@'localhost' identified by '<password>';

rem 刷新权限
flush privileges;

rem 退出 MySQL
exit

rem 重启服务，安装完成
net stop mysql
net start mysql
```

</details>

### 版本管理结构

> 打开 `powershell`

```powershell
# 创建包名称目录
cd $Env:USERPROFILE/space/packages
mkdir ~/space/packages/<package_name>

# 创建包版本目录
cd $Env:USERPROFILE/space/packages/<package_name>
mkdir $Env:USERPROFILE/space/packages/<package_name>/<package_version>

# 将解压后的文件移动进指定版本目录内
cp -Recurse <package_dir> ./

# 如果已经设置当前的版本，需要先删除
rm $Env:USERPROFILE\space\packages\<package_name>\current

# 设置当前版本
Start-Process `
    -FilePath "cmd" ` -ArgumentList "/c", `
    "mklink","/d", `
    "$Env:USERPROFILE\space\packages\<package_name>\current", `
    "$Env:USERPROFILE\space\packages\<package_name>\<package_version>" `
    -Verb RunAs

# 配置 PATH 环境变量
[System.Environment]::SetEnvironmentVariable( `
    "PATH", `
    "$([System.Environment]::GetEnvironmentVariable('PATH', 'USER'))$Env:USERPROFILE\space\packages\<package_name>\current\bin", `
    "User" `
```

