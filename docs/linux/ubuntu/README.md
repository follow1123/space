#  linux 安装显卡驱动

* 修改 blacklist.conf文件：`sudo vim /etc/modprobe.d/blacklist.conf`，在最后一行添加，添加后需要重启

  ```shell
  blacklist nouveau
  ```

* 执行命令安装必要的库：

  * `sudo apt update && sudo apt install build-essential`
  * `sudo apt-get install libglvnd-dev`

* 从Nvidia官网下载驱动文件

  * 使用命令行进入下载的文件的目录

* 安装命令：`sudo bash 文件名`

  * 如果提示X server相关则加上 `-no-x-check`参数
  * 卸载，加上`--uninstall` 参数

## ubuntu 合并状态栏和dock栏

* ​	浏览器安装`gnome shell integration`插件
* 进入[gnome扩展网址](https://extensions.gnome.org/)
  * 搜索`dash to panel`插件 打开即可