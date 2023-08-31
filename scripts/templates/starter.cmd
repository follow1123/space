@echo off

REM 设置编码为UTF-8
chcp 65001 >nul

setlocal
REM 应用配置
REM 从0开始，后面添加的应用加一
REM name 应用名称，用于提示
REM path 应用路径
REM delay 延时，启动应用大概需要的时间，秒为单位
set APP[0].name=nodepad++
set APP[0].path=C:\Users\YF\space\soft\notepad++\notepad++.exe
set APP[0].delay=5
set APP[1].name=
set APP[1].path=
set APP[1].delay=

REM 开始启动
set index=0
:startAppLoop
if defined APP[%index%].name (
	call echo 正在启动：%%APP[%index%].name%%
	if defined APP[%index%].path (
		call echo 文件路径：%%APP[%index%].path%%
		call start "" %%APP[%index%].path%%
	)
	if defined APP[%index%].delay (
		call echo %%APP[%index%].delay%%秒后启动下一个应用
		call timeout /t %%APP[%index%].delay%% >nul
	)
	set /a index+=1
	goto :startAppLoop
)
endlocal
