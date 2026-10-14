# System description

Dotfiles use common links. XWayland system, isn't perfect, but it's close to it. All controls are customized for vim/ nvim. All legacy components and code will removed as well as possible.

The build does not come with wallpaper, set up it.

Run `crontab -e` and paste this `0 0 1 * * /home/rat/.local/dotfiles-arch-linux/bin/paccache-clear` for clean cache every first day of month

# Submodules

- [nvim](/nvim)

Clone with `git clone --recurse-submodules` or run `git submodule update --init` after.

# Navigation

- [/install.sh](/install.sh)
- [Scripts](/bin/)
- [Additional waybar indicators](/waybar/scripts/README.md)
- [GPU undervolt (AMD)](/gpu-undervolt/README.md)

# Preview

![preview](/assets/images/preview.png)
