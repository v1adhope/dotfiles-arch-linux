#!/bin/bash

# Steam fix
export SDL_VIDEODRIVER=x11

# Wayland fix
#export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export GDK_BACKEND="wayland,x11"

exec sway
exec mako
