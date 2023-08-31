# 别名
function ll { lsd -l }
function la { lsd -a }
function lla { lsd -al }
Set-Alias -Name ls -Value lsd
Set-Alias -Name lg -Value lazygit

function cdf { cd $(fd -td | fzf --height 55% --layout=reverse --prompt='❯ ' --info=inline:' ') }

function getenv { Get-ChildItem Env: }

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
function sudocmd {
	sudo wt cmd
}
# 管理员方式打开powershell
function sudopwsh {
	sudo wt pwsh
}
# 管理员方式使用nvim编辑文件
function sudonvim {
	param (
		[string]$Path
	)
	sudo wt "pwsh -c nvim $Path"
}

# ctrl+j 接收全部建议
Set-PSReadLineKeyHandler -Chord "Ctrl+j" -Function ForwardChar

# 设置 Ctrl+A 为行的开头
Set-PSReadLineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine

# 设置 Ctrl+E 为行的结尾
Set-PSReadLineKeyHandler -Key 'Ctrl+e' -Function EndOfLine

# 历史记录下一个
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

# 历史记录上一个
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}


Set-Item -Path 'Env:\FZF_DEFAULT_OPTS' -Value "--height 95% --layout=reverse --preview 'bat --color=always --style=numbers --line-range=:500 {}' --prompt='❯ ' --info=inline:' ' --preview-window=down:60%"

# 安装 z 插件
Invoke-Expression (& { (zoxide init powershell | Out-String) })
# lf配置
Set-Item -Path 'Env:\SHELL' -Value "pwsh"
Set-Item -Path 'Env:\EDITOR' -Value "nvim"
