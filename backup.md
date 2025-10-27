# 备份方案

> 使用 [restic](https://github.com/restic/restic) 工具进行备份，[官方文档](https://restic.readthedocs.io/)

备份文件结构

```bash
backup
├── data # 实际备份数据 restic -r 指定的目录
├── include.txt # 指定备份的文件
├── exclude.txt # 指定排除的文件
├── restic-windows # Windows版压缩包
├── restic-linux # linux版压缩包
└── README.md # 说明文档
```

include.txt

```txt
./space/personal
./space/code/
./space/data/
./space/docs/
./space/dotfiles/
./space/scripts/
```

exclude.txt

```txt
./space/code/frontend/**/node_modules
./space/code/rust/**/target
./space/code/zig/**/.zig-cache
./space/code/other/**/node_modules
```

## 准备工作

### 安装 restic 命令行工具

没有则使用当前目录下的压缩包，解压后可以直接使用

----------

### 设置相关环境变量

- `RESTIC_PASSWORD` - 密码，避免执行多个命令需要多次输入密码
- `RESTIC_REPOSITORY` - 仓库地址，代替 `-r` 选项

设置

| 平台 | 命令 |
| -------------- | --------------- |
| Windows cmd | `set RESTIC_REPOSITORY=/path/to/repo` |
| Windows powershell | `$env:RESTIC_REPOSITORY = "/path/to/repo"` |
| Linux | `export RESTIC_REPOSITORY="/path/to/repo"` |

----------

### 部分协议路径

- `本地路径` - 直接指定绝对路径即可
- `SMB` - `\\192.168.1.10\path`
- `SFTP` - `sftp:user@host:/srv/restic-repo` 如果是 ipv6 或需要指定端口则使用 `sftp://user@[::1]:2222//srv/restic-repo` 格式

其他参考[官方文档](https://restic.readthedocs.io/en/v0.18.1/030_preparing_a_new_repo.html)

----------


## 备份

```powershell
# 切换到需要备份目录的上级目录，我这里需要备份 ~/space 下的部分文件
cd ~/

# 备份命令 加入这个磁盘是 D 盘，不是则修改
restic -r D:\backup\data\ backup --files-from D:\backup\include.txt --exclude-file D:\backup\exclude.txt --tag windows
```


## 备份

```powershell
cd <backup_path>

# 备份命令
restic backup ./backup_data
# 或
restic backup --files-from include.txt --exclude-file exclude.txt --tag <your_tag>
```

## 检查

```powershell
# 快速检查
restic check

# 检查（时间根据快照大小决定）
restic check --read-data

# 如果出现错误，使用 repair 尝试修复

# 重构索引
restic repair index

# 修复损坏文件
restic repair index

# 修复快照
restic repair snapshots
```

## 复制

```powershell
# 复制一个仓库到另一个仓库，-r 选项指定的是目标仓库（复制到的仓库）--from-repo 指定的是原始仓库
# 这是是从本地仓库，复制到远程仓库
restic -r "\\192.168.4.37\backup\data" copy --from-repo D:\backup\data\
```

## 恢复

```powershell
# 文件按快照内的目录结构恢复到 /path/to/restored 目录下
restic restore latest --target /path/to/restored

# 将快照内 /space/code 下的所有文件和文件夹恢复到 /path/to/restored 目录下
restic restore latest:space/code --target /path/to/restored

# 将快照内 /space 下的 scripts 目录单独恢复到 /path/to/restored 目录下
restic restore latest:space --include scripts --target /path/to/restored
```

### 多个 Windows 设备之间恢复时 Owner 和 Acl 问题

将一个 Windows 下备份的文件 恢复到另一个 Windows 设备下时，会出现无法访问的权限问题

这主要是因为两个设备的账户不同，导致备份出来的文件都是未知账户的权限

使用 `icacls <path_to_restored> /t /c /q /reset` 命令重置恢复的这个目录以及子文件下的权限
