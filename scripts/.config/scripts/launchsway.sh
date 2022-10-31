#!/bin/bash

# QT5 fix
export QT_QPA_PLATFORMTHEME=qt5ct

# Wayland fix
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export GDK_BACKEND="wayland,x11"

exec sway
exec mako
