@echo off

setlocal

set nginx_home=%USERPROFILE%\space\packages\nginx\current
set nginx_pid_file=%nginx_home%\logs\nginx.pid
set nginx_cmd=%nginx_home%\nginx.exe

if "%1" == "" (
	call :start_nginx
) else (
	start %nginx_cmd% -p %nginx_home% %*
)

endlocal

goto :eof

:is_running
for /f "tokens=2 delims=," %%i ^
in ('tasklist /nh /fi "imagename eq nginx.exe" /fo csv') ^
do set nginx_pid=%%i

if not defined nginx_pid (exit /b 1)
if %nginx_pid% neq "" (exit /b 0)
goto :eof

:start_nginx
call :is_running
if %ERRORLEVEL% equ 0 (
	echo nginx is running
	pause
	goto :eof
)

start %nginx_cmd% -p %nginx_home%
goto :eof
