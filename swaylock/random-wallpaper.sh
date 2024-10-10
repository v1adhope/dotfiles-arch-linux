#!/bin/bash

## Settings
config_location="${0%/*}/config"
wallpaper_pwd="$LOCK_WALLPAPER_PATH"
file_pattern="wallpaper"

## WARN: don't touch if you don't know what you're doing
file_count=$(($(ls $wallpaper_pwd | wc -l) - 1))
if [ "$file_count" -lt 1 ]; then
  echo "no wallpapers"
  exit 1
fi

wallpaper_path=$wallpaper_pwd$file_pattern
file_name=$(basename $wallpaper_path.*)
extension=".${file_name##*.}"
file1="$wallpaper_path$extension"
file2="$wallpaper_path-$((1 + $RANDOM % $(($file_count))))$extension"

sed -i "s,^image.*,image=\"$file1\"," $config_location

tempdir="$(mktemp -d)"

mv "$file1" "$tempdir/tmpfile" &&
mv "$file2" "$file1" &&
mv "$tempdir/tmpfile" "$file2" &&
rm -rf "$tempdir"
