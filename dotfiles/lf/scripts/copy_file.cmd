@echo off

set param=%1

if "%param%"=="-a" (goto :copy_abstract_path)
if "%param%"=="-n" (goto :copy_name)
if "%param%"=="-N" (goto :copy_full_name)
if "%param%"=="-d" (goto :copy_dir_path)
goto :EOF

REM 复制文件绝对路径
:copy_abstract_path
echo %f:"=% | clip
goto :EOF

REM 复制文件名称
:copy_name
for %%i in (%f%) do echo %%~ni | clip
goto :EOF

REM 复制文件名称,包含扩展
:copy_full_name
for %%i in (%f%) do echo %%~nxi | clip
goto :EOF

REM 复制当前目录路径
:copy_dir_path
echo %PWD:"=% | clip
goto :EOF

