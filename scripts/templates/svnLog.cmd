@echo off

REM �������±�����Ϊ�ֲ����� 
setlocal
REM �û�����
set username=
REM Ĭ�ϲ�ѯ����һ������ 
set querySize=1

REM svn ��ַ
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
REM svn��ַ��Ӧ�ı��ص�ַ
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
	echo ������n��ַ��Ӧ��key����%0�ļ��ڲ鿴
	goto:end
)
if not defined url[%queryUrl%] (
	echo %queryUrl%��Ӧsvn��ַ�����ڣ���%0�ļ�������
	goto:end
)

call set curUrl=%%url[%queryUrl%]%%

REM �±�
set /a i=0
REM ����for ѭ����ȡ�����ۼӵ�i��������Ҫ����setlocal enabledelayedexpansion�������Զ�ȡ��ʱ������ʹ��!i!��ȡ

setlocal enabledelayedexpansion
for /f "delims=" %%a in ( 'svn log %curUrl% -v -l %querySize% --search %username%' ) do (
	set line[!i!]=%%a
	set /a i+=1
)
setlocal enabledelayedexpansion
set /a i=0
:start
if defined line[%i%] (
	REM �滻|���ţ���ֹ�޷���� 
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
