#!/bin/bash

# Steam fix
# export SDL_VIDEODRIVER=x11
# export SDL_DYNAMIC_API=/usr/lib/libSDL2-2.0.so

# Firefox fix
export MOZ_ENABLE_WAYLAND=1

# Wayland fix
export XDG_SESSION_TYPE=wayland
export QT_WAYLAND_FORCE_DPI=physical
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=gnome
export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export _JAVA_AWT_WM_NONREPARENTING=1
# export QT_QPA_PLATFORM=wayland
# export GDK_BACKEND="wayland,x11"
