#!/bin/bash

wallpaper_path="$HOME/.config/swaylock/wallpapers/"

# Don't foget change in swaylock config
file_format="jpg"

file_count=$(($(ls $wallpaper_path | wc -l) - 1))
if [ "$file_count" -lt 1 ]; then
  echo "no wallpapers"
  exit 1
fi

file1="wallpaper.$file_format"
file2="wallpaper-$(($RANDOM % $(($file_count - 1)) + 1 )).$file_format"

tempdir="$(mktemp -d)"

mv "$wallpaper_path$file1" "$tempdir/tmpfile" &&
mv "$wallpaper_path$file2" "$wallpaper_path$file1" &&
mv "$tempdir/tmpfile" "$wallpaper_path$file2" &&
rm -rf "$tempdir"
