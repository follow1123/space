###############################################################################
#                                                                             #
#                                  colorscheme                                #
#                                                                             #
###############################################################################

$PSStyle.FileInfo.Directory = "`e[34;1m"

###############################################################################
#                                                                             #
#                                    alias                                    #
#                                                                             #
###############################################################################

# 移除powershell自带的别名
Remove-Alias -Name "sl" -Force # 默认是Set-Location
Remove-Alias -Name "where" -Force # 默认是Where-Object，移除后使用系统自带的where程序

Set-Alias -Name whereis -Value Get-Command
Set-Alias -Name which -Value Get-Command

Set-Alias -Name lg -Value lazygit
Set-Alias -Name ld -Value lazydocker

Set-Alias -Name jdks -Value "$Env:USERPROFILE/space/scripts/jdk_select.ps1"
Set-Alias -Name mvns -Value "$Env:USERPROFILE/space/scripts/maven_select.ps1"

###############################################################################
#                                                                             #
#                                  function                                   #
#                                                                             #
###############################################################################

function ll { Get-ChildItem | Format-Table -HideTableHeaders -AutoSize }
function lla {
    Get-ChildItem -Attributes Archive,Compressed,Device,Directory,Encrypted,Hidden,IntegrityStream,Normal,NoScrubData,NotContentIndexed,Offline,ReadOnly,ReparsePoint,SparseFile,System,Temporary | Format-Table -HideTableHeaders -AutoSize 
}

function env { Get-ChildItem Env: }

# 使用管理员方式打开
function sudo {
    param(
        [string]$Command,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    Start-Process -FilePath $Command -ArgumentList $Arguments -Verb RunAs
}

# 管理员方式打开cmd
function sudocmd { sudo alacritty.exe --command cmd }

# 管理员方式打开powershell
function sudopwsh { sudo alacritty.exe --command pwsh }

###############################################################################
#                                                                             #
#                                   keymap                                    #
#                                                                             #
###############################################################################

Set-PSReadLineOption -EditMode Emacs # 可选的，选择编辑模式

###############################################################################
#                                                                             #
#                                     env                                     #
#                                                                             #
###############################################################################

# fzf选项配置
Set-Item -Path 'Env:\FZF_DEFAULT_OPTS' -Value "--height 95% --layout=reverse --prompt='❯ ' --info=inline:' ' --preview-window=down:60%"
# lf配置
Set-Item -Path 'Env:\EDITOR' -Value "nvim"

###############################################################################
#                                                                             #
#                                    plugin                                   #
#                                                                             #
###############################################################################

# 安装 z 插件
Invoke-Expression (& { (zoxide init powershell | Out-String) })
