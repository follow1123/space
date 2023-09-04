################################
#             别名             #
################################

Set-Alias -Name ls -Value lsd
Set-Alias -Name lg -Value lazygit

################################
#             函数             #
################################

function ll { lsd -l }
function la { lsd -a }
function lla { lsd -al }

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
function sudocmd { sudo wt cmd }

# 管理员方式打开powershell
function sudopwsh { sudo wt pwsh }

# 管理员方式使用nvim编辑文件
function sudonvim {
	param (
		[string]$Path
	)
	sudo wt "pwsh -c nvim $Path"
}

################################
#          按键定义            #
################################

# 自定义按键
Set-PSReadLineKeyHandler -key "Alt+i" -Function AcceptSuggestion			# 接受补全建议
Set-PSReadLineKeyHandler -key "Alt+o" -Function AcceptNextSuggestionWord	# 接受一个单词的补全建议
# 模拟linux终端下的默认快捷键
Set-PSReadLineKeyHandler -Key "Ctrl+a" -Function BeginningOfLine			# 行首
Set-PSReadLineKeyHandler -Key "Ctrl+e" -Function EndOfLine					# 行尾
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardChar				# 向前移动一个字符
Set-PSReadLineKeyHandler -Key "Ctrl+b" -Function BackwardChar				# 向后移动一个字符
Set-PSReadLineKeyHandler -Key "Alt+f" -Function ForwardWord					# 向前移动一个单词
Set-PSReadLineKeyHandler -Key "Alt+b" -Function BackwardWord				# 向后移动一个单词
Set-PSReadLineKeyHandler -Key "Ctrl+k" -Function KillLine					# 删除到行尾
Set-PSReadLineKeyHandler -Key "Ctrl+u" -Function BackwardKillLine			# 删除到行首
Set-PSReadLineKeyHandler -Key "Ctrl+n" -ScriptBlock {						# 上一个历史记录
	[Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -ScriptBlock {						# 下一个历史记录
    [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

################################
#          环境变量            #
################################

# fzf选项配置
Set-Item -Path 'Env:\FZF_DEFAULT_OPTS' -Value "--height 95% --layout=reverse --prompt='❯ ' --info=inline:' ' --preview-window=down:60%"
# lf配置
Set-Item -Path 'Env:\EDITOR' -Value "nvim"

# 安装 z 插件
Invoke-Expression (& { (zoxide init powershell | Out-String) })
