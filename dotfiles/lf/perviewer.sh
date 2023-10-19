#!/bin/sh

# 预览文件
preview_file(){
	bat \
	--color=always \
	--style=header-filename,header-filesize,grid \
	--theme="Visual Studio Dark+" \
	$1
}

# 默认预览文件的方式
default_perviewer(){
	local file=$1
	case "$file" in
		*.tar*) tar tf "$file";;
		*.zip) unzip -l "$file";;
		*.rar) unrar l "$file";;
		*.7z) 7z l "$file";;
		*) preview_file $file;;
	esac
}

draw() {
  ~/.config/lf/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

if [ -n "$FIFO_UEBERZUG" ]; then
  case "$(file -Lb --mime-type -- "$file")" in
    image/*)
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
      ;;
    video/*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      ffmpegthumbnailer -i "$file" -o "$cache" -s 0
      draw "$cache" "$@"
      ;;
  esac
fi

default_perviewer $file
exit 0
