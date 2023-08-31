@echo off

REM 设置以下变量都为局部变量 
setlocal
REM 用户名称
set username=
REM 默认查询最新一条数据 
set querySize=1

REM svn 地址
set url[gdzy]=
set url[hbsj]=
set url[gzsj]=
set url[szyc]=
set url[shyc]=
set url[gdsj]=
set url[gdzy]=
set url[zjsj]=
set url[zjzy]=
set url[sxzy]=
set url[jlgy]=
set url[fjyc]=
set url[tfm2]=
set url[cqyc]=
set url[hljsj]
set url[scyc]=
set url[cqzy]=
set url[sczy]=
set url[henzy]
set url[jxsj]=
set url[sxyc]=
REM svn地址对应的本地地址
set urlConfig[0].remote
set urlConfig[0].local=
set urlConfig[1].remote
set urlConfig[1].local=
set urlConfig[2].remote
set urlConfig[2].local=
set urlConfig[3].remote
set urlConfig[3].local=

set queryUrl=%1
if not defined queryUrl (
	echo 请输入n地址对应的key，在%0文件内查看
	goto:end
)
if not defined url[%queryUrl%] (
	echo %queryUrl%对应svn地址不存在，在%0文件内配置
	goto:end
)

call set curUrl=%%url[%queryUrl%]%%

REM 下标
set /a i=0
REM 由于for 循环内取不到累加的i变量，需要设置setlocal enabledelayedexpansion开启可以读取临时变量，使用!i!读取

setlocal enabledelayedexpansion
for /f "delims=" %%a in ( 'svn log %curUrl% -v -l %querySize% --search %username%' ) do (
	set line[!i!]=%%a
	set /a i+=1
)
setlocal enabledelayedexpansion
set /a i=0
:start
if defined line[%i%] (
	REM 替换|符号，防止无法输出 
	call set line[%i%]=%%line[%i%]:^|=%%
	call set head=%%line[%i%]:~0,4%%
	if "%head%"=="   M" (
		echo "%i% %head%"
		REM call set line[%i%]=%%line[%i%]:~5%%
		REM call echo %i% %%line[%i%]%%
	)
	call echo %i% %%line[%i%]%%
	REM call echo %%line[%i%]%%
	set /a i+=1
	goto:start
)

:end
endlocal
