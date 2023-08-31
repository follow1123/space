# 配置文件

## visual studio code

* `ctrl + p` 输入 import 找到 `profiles: imports profile...`
* 选择[vsCode.code-profile](./visual_studio_code/vsCode.code-profile)文件导入

## lf

* 使用管理员打开cmd
* 执行`mklink /d  %LOCALAPPDATA%\lf %USERPROFILE%\space\dotfiles\lf`

## powershell

* 安装`winget install --id Microsoft.PowerShell`
* 配置
    * 使用管理员打开cmd
    * `for /f %i in ('pwsh -c $PROFILE') do mklink %i %USERPROFILE%\space\dotfiles\powershell\Microsoft.PowerShell_profile.ps1`

## alacritty

* 安装 `scoop install alacritty`
* 配置
    * 使用管理员打开cmd
    * `mklink /d %APPDATA%\alacritty %USERPROFILE%\space\dotfiles\alacritty`

## lsd

* 安装
    * `scoop install lsd`
* 配置
    * 使用管理员打开cmd
    * `mklink /d %APPDATA%\lsd %USERPROFILE%\space\dotfiles\lsd`

## fd 

* 安装
    * `scoop install fd`

## ripgrep 

* 安装
    * `scoop install ripgrep`

## bat 

* 安装
   * `scoop install bat`
* 使用管理员方式打开cmd
   * mklink /d %APPDATA%\bat %USERPROFILE%\space\dotfiles\bat

## zoxide 

* 安装
    * `scoop install zoxide`
* 配置
    * 打开powershell
    * `echo "Invoke-Expression (& { (zoxide init powershell | Out-String) })" >> $PROFILE`
