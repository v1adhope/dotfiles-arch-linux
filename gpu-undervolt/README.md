It should work on Polaris, Vega (unfortunately Vega found on AMD APUs does not expose this API) and Navi cards, and it can be used to easily manage multiple AMD graphics cards.
See https://github.com/sibradzic/amdgpu-clocks for more information and this https://wiki.archlinux.org/title/AMDGPU

> The current installation script is designed for one video card 5xxx series!

Use your pattern `custom-values/amdgpu-custom-states.card0`
For find it you can run this command
```cat $(readlink -f /sys/class/drm/card0/device)/pp_od_clk_voltage```
