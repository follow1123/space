#!/bin/sh
if [ -n "$FIFO_UEBERZUG" ]; then
  path="$(printf '%s' "$1" | sed 's/\\/\\\\/g;s/"/\\"/g')"
  printf '{"action": "add", "identifier": "preview", "x": %d, "y": %d, "width": %d, "height": %d, "scaler": "contain", "scaling_position_x": 0.5, "scaling_position_y": 0.5, "path": "%s"}\n' \
    "$4" "$5" "$2" "$3" "$1" >"$FIFO_UEBERZUG"

  # TODO 显示图片详情功能
  # height=$3
  # count=$((h / 3))
  # printf '\n%.0s' $(seq 1 $count)
  # file -Lb -- "$1" | fold -s -w "$2"
fi
