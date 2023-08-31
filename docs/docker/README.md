# docker安装

* 参考https://blog.csdn.net/weixin_43961117/article/details/126125976教程
* debian系统官方安装地址https://docs.docker.com/engine/install/debian/
* 新建文件`/etc/docker/daemon.json`
* 添加镜像

```json
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}
```



# docker gitlab备份

* `docker ps`获取 container id
* `docker exec -i -t （这里填container id） /bin/bash`

* `gitlab-rake gitlab:backup:create`
* 输出`Creating backup archive xxx_xxx.tar`备份成功
* 文件在创建容器的命令映射的gitlab数据路径下`data/backups`下

# docker 命令

* `docker images` 查看已有的镜像
* `docker ps -a` 查看所有容器
* `docker rm` 删除容器
* `docker rmi` 删除镜像

`docker build -t 镜像名称:镜像标签 Dockerfile目录` 制作镜像   