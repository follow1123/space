@echo off

set file_ext=%~x1
set file=%1

if /i "%file_ext%"==".zip" (goto :preview_archive)
if /i "%file_ext%"==".rar" (goto :preview_archive)
if /i "%file_ext%"==".tar" (goto :preview_archive)
if /i "%file_ext%"==".gz" (goto :preview_archive)
if /i "%file_ext%"==".bz" (goto :preview_archive)
if /i "%file_ext%"==".zip" (goto :preview_archive)
if /i "%file_ext%"==".jar" (goto :preview_archive)
if /i "%file_ext%"==".war" (goto :preview_archive)
if /i "%file_ext%"==".apk" (goto :preview_archive)

goto :preview_file

REM 预览普通文件
:preview_file
bat ^
--color=always ^
--style=header-filename,header-filesize,grid ^
--theme="Visual Studio Dark+" ^
%file%
goto :EOF

REM 预览压缩包
:preview_archive
bz l %file%
goto :EOF
