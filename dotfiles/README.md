# 配置

> 默认基于debian配置

## git

```bash
# 安装
sudo apt install git -y
# 配置
ln -s ~/space/dotfiles/git/gitconfig ~/.gitconfig
```
## zsh

```bash
# 插件下载
mkdir -p ~/.local/share/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.local/share/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/powerlevel10k
# 如果有问题执行以下代码切换到固定的commit
cd ~/.local/share/zsh/powerlevel10k && git checkout 0af598cbed78660066f8a8f4465844501ba5695b
cd ~/.local/share/zsh/zsh-autosuggestions && git checkout a411ef3e0992d4839f0732ebeb9823024afaaaa8
cd ~/.local/share/zsh/zsh-syntax-highlighting && git checkout 754cefe0181a7acd42fdcb357a67d0217291ac47
# 安装
sudo apt install zsh -y

# 配置
ln -s ~/space/dotfiles/zsh/zshrc ~/.zshrc

# 配置用户shell
chsh -s /bin/zsh

# 配置root shell
sudo chsh -s /bin/zsh
```

## rust

>  用于安装rust编写的部分软件

* 参考[官网](https://www.rust-lang.org/)提供的脚本安装方式
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
## go

* 先从[官网](https://go.dev/)下载压缩包

```bash
# 解压
sudo tar -zxvf 压缩包 -C 目标路径

# 相关环境变量在.zshrc内导出
export GOROOT=/usr/local/go
export GOPATH=$HOME/space/code/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
```

## nodejs

* 先从[官网](https://nodejs.org)下载压缩包
```bash
# 解压下载.tar.xz文件
tar xf 压缩包

# 相关环境变量在.zshrc内导出
export NODEJS_HOME=$HOME/space/env/nodejs/18.18.2
```

## neovim

* 从源码安装参考[github wiki](https://github.com/neovim/neovim/wiki/Building-Neovim)

```bash
# 安装依赖
sudo apt install cmake xclip gettext -y

# 安装
cd ~/space/soft
git clone https://github.com/neovim/neovim
cd neovim
# 切换到稳定版分支
git checkout stable
# 编译安装
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# 配置
cd ~/.config
git clone https://github.com/follow1123/nvim.git

# 添加neovim配置路径到环境变量,在其他位置使用
export NVIM_CONF_HOME=$HOME/.config/nvim

# 软连接nvim配置到root用户下
sudo ln -s ~/.config/nvim /root/.config
```
## lazygit

```bash
# 安装
go install github.com/jesseduffield/lazygit@latest

# 配置
ln -s ~/space/dotfiles/lazygit ~/.config
```

## lf

```bash
# 依赖 视频预览
sudo apt install ffmpegthumbnailer -y
# 安装
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest

# 配置
ln -s ~/space/dotfiles/lf ~/.config
```

## fzf

```bash
# 安装
git clone --depth 1 https://github.com/junegunn/fzf.git ~/space/soft/fzf
~/space/soft/fzf/install
```

## btop

```bash
# 安装
sudo apt install btop -y

# 配置
ln -s ~/space/dotfiles/btop ~/.config
```
## bat 


```bash
# 安装
cargo install bat

# 配置
ln -s ~/space/dotfiles/bat ~/.config
```

## ueberzugpp

> 在终端内显示图像,lf内使用

```bash
# 安装依赖
sudo apt install nlohmann-json3-dev libcli11-dev libvips-dev libsixel-dev chafa openssl libtbb-dev libspdlog-dev libfmt-dev libxcb-res0-dev libchafa-dev -y

# 安装
cd ~/space/soft
git clone https://github.com/jstkdng/ueberzugpp.git
cd ueberzugpp 
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_OPENCV=off ..
cmake --build .

# 配置
sudo ln -s ~/space/soft/ueberzugpp/build/ueberzug /usr/local/bin/ueberzug
sudo ln -s ~/space/soft/ueberzugpp/build/ueberzugpp /usr/local/bin/ueberzugpp
```
## alacritty

```bash
# 安装
cargo install alacritty

# 配置
ln -s ~/space/dotfiles/alacritty ~/.config/alacritty
```

## firefox

* 先从[官网](https://www.mozilla.org/zh-CN/firefox/new/)下载压缩包
* 参考官方[安装文档](https://support.mozilla.org/zh-CN/kb/linux-firefox)

```bash
# 安装依赖
sudo apt install libdbus-glib-1-2 -y

# 解压
tar xjf firefox-*.tar.bz2 -C ~/space/soft

# 配置
sudo ln -s ~/space/soft/firefox/firefox /usr/local/bin/firefox
```
## 其他

```bash
sudo apt install neofetch
cargo install lsd fd-find ripgrep zoxide
```
