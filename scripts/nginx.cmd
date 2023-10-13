@echo off

cd C:\Users\yf\space\env\nginx\1.24.0

if "%1" == "" (goto :start_nginx)
nginx.exe %*

goto :EOF

:start_nginx
start nginx.exe
