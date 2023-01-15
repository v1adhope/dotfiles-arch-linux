#!/bin/bash

# Hidden files on top
# export LC_COLLATE="C"

# Runner alias
alias nnn="nnn -a -e"
# -H - show hidden files

# Bookmarks
export NNN_BMS="d:$HOME/Documents;D:$HOME/Downloads;p:$HOME/Pictures;v:$HOME/Videos;m:$HOME/Dropbox/DropsyncFiles/music"

# Color theme
BLK="04" CHR="04" DIR="0c" EXE="79" REG="00" HARDLINK="00" SYMLINK="0d" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# Extended archive formats
export NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip)$"

export NNN_FIFO=/tmp/nnn.fifo

### Plugins
#
export NNN_PLUG="p:preview-tui;u:getplugs;i:imgview"
#
# Preview-tui
export SPLIT="v"
