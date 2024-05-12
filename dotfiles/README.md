# 配置

## wezterm

```cmd
REM 创建配置文件夹
mkdir %USERPROFILE%\.config

REM 安装
winget install --id wez.wezterm

REM 配置，使用管理员打开cmd
mklink /d %USERPROFILE%\.config\wezterm %USERPROFILE%\space\dotfiles\wezterm
```

## alacritty

```cmd
REM 安装
scoop install alacritty

REM 配置，使用管理员打开cmd
mklink /d %APPDATA%\alacritty %USERPROFILE%\space\dotfiles\alacritty
```

## powershell

```cmd
REM 安装
winget install --id Microsoft.PowerShell

REM 配置，使用管理员打开cmd
for /f %i in ('pwsh -c $PROFILE') do mklink %i %USERPROFILE%\space\dotfiles\powershell\Microsoft.PowerShell_profile.ps1
```

## git

```cmd
REM 安装
winget install --id Git.Git

REM 配置，打开powershell
TODO
```

## lf

```cmd
REM 安装
scoop install lf

REM 配置，使用管理员打开cmd
mklink /d %LOCALAPPDATA%\lf %USERPROFILE%\space\dotfiles\lf
```

## lazygit

```cmd
REM 安装
scoop install lazygit

REM 配置，使用管理员打开cmd
mklink /d %APPDATA%\lazygit %USERPROFILE%\space\dotfiles\lazygit
```

## bat 

```cmd
REM 安装
scoop install bat

REM 配置，使用管理员打开cmd
mklink /d %APPDATA%\bat %USERPROFILE%\space\dotfiles\bat
```

## zoxide 

```cmd
REM 安装
scoop install zoxide

REM 配置，打开powershell（这个配置默认已经在powershell配置内）
echo "Invoke-Expression (& { (zoxide init powershell | Out-String) })" >> $PROFILE
```

## Bandzip

```cmd
REM 安装
winget install --id Bandisoft.Bandizip
```

## fd

```cmd
REM 安装
scoop install fd
```

## ripgrep

```cmd
REM 安装
scoop install ripgrep
```

## btop

```cmd
REM 安装
scoop install btop
```

## fzf

```cmd
REM 安装
scoop install fzf
```

## jq

```cmd
REM 安装
scoop install jq
```

## xmllint

```cmd
REM 安装
scoop install xmllint
```

## Visual Studio Code 

* TODO

## IntelliJ IDEA

* TODO
