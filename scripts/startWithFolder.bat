@echo off
if %1 == 1 (
	if exist "%2\.git" (lazygit -p %2) else (lazygit)
)