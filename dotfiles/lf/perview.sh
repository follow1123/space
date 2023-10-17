#!/bin/bash

echo $1

file=$1

# 预览文件
function preview_file(){
	bat \
	--color=always \
	--style=header-filename,header-filesize,grid \
	--theme="Visual Studio Dark+" \
	$file
}

preview_file
# case "$file" in
#     *.tar*) tar tf "$file";;
#     *.zip) unzip -l "$file";;
#     *.rar) unrar l "$file";;
#     *.7z) 7z l "$file";;
# 	*) preview_file;;
# esac
