# colorscheme -----------------------------------------------------------------

$PSStyle.FileInfo.Directory = "`e[34;1m"

# function --------------------------------------------------------------------

# 使用管理员方式打开
function sudo {
    param(
        [string]$Command,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    Start-Process -FilePath $Command -ArgumentList $Arguments -Verb RunAs
}

# 根据进程id查找其父进程
function findParentProcess {
	param (
		[int]$ProcessId,
		[int]$Depth = 5
	)

	if (-not $ProcessId) {
		Write-Output 'no process id'
		return
	}

	$processArray=@($null) * $Depth

	for ($i = 0; $i -lt $Depth; $i++) {
		$processArray[$i] = Get-CimInstance Win32_Process -Filter "ProcessId = $ProcessId"
		if ($processArray[$i].ProcessId -eq 0) {
			break
		}
		$ProcessId = $processArray[$i].ParentProcessId
	}

	Write-Output $processArray
}

function fp {
	fzf --preview 'bat --color=always {-1} --plain' `
	--preview-window=right `
	--bind 'ctrl-k:change-preview-window(50%|hidden|),ctrl-u:preview-page-up,ctrl-d:preview-page-down'
}

function fgrep {
	rg --color=always --line-number --no-heading --smart-case "${*:-}" | `
	fzf --ansi --delimiter : `
	--color "hl:-1:underline,hl+:-1:underline:reverse" `
	--preview 'bat --color=always {1} --plain --highlight-line {2}' `
	--height 90% --layout=reverse --info=inline --preview-window=right `
	--bind 'ctrl-k:change-preview-window(50%|hidden|),ctrl-u:preview-page-up,ctrl-d:preview-page-down'
}

function fgd {
	[string[]]$args
	git diff $args --name-only | `
	fzf -m --ansi --preview "git diff $args --color=always -- {-1}" `
	--height 90% --layout=reverse --info=inline --preview-window=right,70% `
	--bind 'ctrl-k:change-preview-window(50%|hidden|),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
}

# alias -----------------------------------------------------------------------

# 移除powershell自带的别名
Remove-Alias -Name "sl" -Force # 默认是Set-Location
Remove-Alias -Name "where" -Force # 默认是Where-Object，移除后使用系统自带的where程序

Set-Alias -Name lg -Value lazygit
Set-Alias -Name ld -Value lazydocker
Set-Alias -Name make -Value mingw32-make.exe

Set-Alias -Name jdks -Value "$Env:USERPROFILE/space/scripts/jdk_select.ps1"
Set-Alias -Name mvns -Value "$Env:USERPROFILE/space/scripts/maven_select.ps1"
Set-Alias -Name vim -Value "$Env:USERPROFILE/space/scripts/vim.cmd"

# keymap ----------------------------------------------------------------------

Set-PSReadLineOption -EditMode Emacs # 可选的，选择编辑模式
Set-PSReadlineOption -BellStyle None # 禁用铃声
Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($(Get-Content (Get-PSReadLineOption).HistorySavePath | fzf))
}
Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($(fd -I | fzf))
}
Set-PSReadLineKeyHandler -Chord Alt+c -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("cd $(fd -t d -I | fzf)")
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# env -------------------------------------------------------------------------

# fzf选项配置
Set-Item -Path 'Env:\FZF_DEFAULT_OPTS' -Value "--height 70% --layout=reverse --info=inline --preview-window=down:60%"

# plugins ---------------------------------------------------------------------

# 安装 z 插件
Invoke-Expression (& { (zoxide init powershell | Out-String) })
