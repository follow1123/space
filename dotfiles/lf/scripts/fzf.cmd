@echo off

for /f "tokens=*" %%i in ('fd -t d ^| fzf') do ( 
	set choice=%%i
)


set res=%choice:\=\\%
lf -remote "send %1 cd '%res%'"
