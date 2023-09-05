@echo off

start /B nvim-qt -- -u %LOCALAPPDATA%\nvim\init_min.lua %*
