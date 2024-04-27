@echo off

for /f %%i in ('zoxide.exe query %2') do ( 
	set choice=%%i
)

set res=%choice:\=\\%
lf -remote "send %1 cd '%res%'"
