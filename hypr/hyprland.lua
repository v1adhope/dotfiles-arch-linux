-- === Envs ===
local homePath = os.getenv("HOME")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_PICTURES_DIR", homePath .. "/Pictures/Screenshots")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

hl.env("GTK_THEME", "Adwaita:dark")

hl.env("QT_STYLE_OVERRIDE", "adwaita-dark")
hl.env("QT_WAYLAND_DECORATION", "adwaita")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

-- === Executes ===
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("mako")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("dropbox & obsidian & chromium & Telegram & AmneziaVPN")
end)

-- === Look nad Feel ===
hl.monitor({ output = "", mode = "2560x1440@155", position = "auto", scale = 1 })

-- Ref https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 5,
		border_size = 3,
		col = {
			active_border = "rgba(3546A1CC)",
			inactive_border = "rgba(595959aa)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		inactive_opacity = 0.99,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},

	animations = { enabled = true },

	input = {
		kb_layout = "us,ru",
		kb_options = "grp:win_space_toggle,ctrl:swapcaps",
		follow_mouse = 2,
		sensitivity = 0.0,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	ecosystem = {
		no_donation_nag = true,
	},
})

-- === Windows and Workspaces ===
-- Ref https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- To get more information about a window’s class, title, XWayland status or its size,
-- you can use "hyprctl clients"
hl.window_rule({ match = { class = "obsidian" }, workspace = "1 silent" })
hl.window_rule({ match = { class = "chromium" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "org.telegram.desktop" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "homebank" }, workspace = "5 silent" })
hl.window_rule({ match = { class = "org.qbittorrent.qBittorrent" }, workspace = "6 silent" })
-- stylua: ignore
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, workspace = "7 silent", float = true, center = true, size = { 1600, 1200 } })
-- stylua: ignore
hl.window_rule({ match = { title = "Picture in picture" }, pin = true, float = true, size = { 450, 255 }, move = { 2100, 1160 } })

-- === Binds ===
-- Ref https://wiki.hypr.land/Configuring/Basics/Binds/
-- See the uncommon syms https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h
local mainMod = "SUPER"
-- stylua: ignore
local openTerminal = 'WS=$(hyprctl clients | grep -m 1 -A 29 "Alacritty" | grep -oP "workspace: \\K\\S+"); if [ -z "$WS" ]; then alacritty; else hyprctl notify 1 3000 0 "Alacritty on Workspace $WS"; fi'
local screenLocker = "hyprlock"
local appLauncher = "fuzzel"

-- stylua: ignore
local makeScreenshot = 'grim -g "$(slurp -o)" -t ppm - | satty --filename - --output-filename "$XDG_PICTURES_DIR/$(date "+%Y%m%d_%Hh%Mm%Ss_satty").png"'

local gracefulExit = 'command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch "hl.dsp.exit()"'

-- Ecosystem
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(openTerminal))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(gracefulExit))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(screenLocker))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(appLauncher))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd(makeScreenshot))

-- Multimedia XF86 keys
-- See https://wiki.linuxquestions.org/wiki/XF86_keyboard_symbols
-- stylua: ignore
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
-- stylua: ignore
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
-- stylua: ignore
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Navigation
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

for direction, key in pairs({ left = "H", right = "L", up = "K", down = "J" }) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

for workspace = 1, 10 do
	local key = workspace % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mainMod .. " + S", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + R", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
