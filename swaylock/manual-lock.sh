#!/bin/bash

## Customization block
${0%/*}/random-wallpaper.sh

## The block below is always the last one
swayidle \
  timeout 10 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' &

makoctl mode -a away

## Section before lock
swaylock
## Section after unlock

makoctl mode -r away

## Cancel swayidle
kill %%
