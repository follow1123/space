@echo off

set param=%1

if "%param%"=="-c" (goto :create_archive)
if "%param%"=="-e" (goto :extract_archive)
goto :EOF

REM 创建压缩文件
:create_archive
set name=%2

setlocal enabledelayedexpansion
set f=a/b/json.txt
if "%name%"=="" (for %%i in (!f!) do (set name=%%~ni.zip))
echo %name%
endlocal

goto :EOF
