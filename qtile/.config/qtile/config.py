from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import (
    Click,
    Drag,
    Group,
    Key,
    Match,
    hook,
    Screen,
    KeyChord,
    ScratchPad,
    DropDown,
)
from libqtile.lazy import lazy
from pathlib import Path
import os
import subprocess
from libqtile import hook
from libqtile.dgroups import simple_key_binder
import re

mod = "mod4"
alt = "mod1"
terminal = "ghostty"

# Get home path
home = str(Path.home())

# ---------------------------------------------------------------------------- #
#                                    Keybind                                   #
# ---------------------------------------------------------------------------- #


keys = [
    # ---------------------------------------------------------------------------- #
    #                                     Focus                                    #
    # ---------------------------------------------------------------------------- #
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window around",
    ),
    # ---------------------------------------------------------------------------- #
    #                                     Move                                     #
    # ---------------------------------------------------------------------------- #
    Key(
        [mod, "shift"],
        "Left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "Right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    # ---------------------------------------------------------------------------- #
    #                                     Swap                                     #
    # ---------------------------------------------------------------------------- #
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    # ---------------------------------------------------------------------------- #
    #                                    windows                                   #
    # ---------------------------------------------------------------------------- #
    Key(
        [mod],
        "v",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "t", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "n", lazy.window.toggle_minimize(), desc="Toggle minimize"),
    Key(
        [mod, "shift"],
        "n",
        lazy.group.next_window(),
        desc="Focus next (even minimized)",
    ),
    # ---------------------------------------------------------------------------- #
    #                                      Qtile                                     #
    # ---------------------------------------------------------------------------- #
    # Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key(
        [mod, "shift"],
        "r",
        lazy.spawn("bash -c ~/.config/qtile/scripts/reload_config.sh"),
        desc="Reload Qtile and Polybar",
    ),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "l",
        lazy.spawn("betterlockscreen -l dimblur -- --clock"),
        desc="Lock screen",
    ),
    # ---------------------------------------------------------------------------- #
    #                                     Media                                    #
    # ---------------------------------------------------------------------------- #
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume 0 +5%"),
        desc="Volume Up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume 0 -5%"),
        desc="volume down",
    ),
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute"), desc="Volume Mute"),
    # ---------------------------------------------------------------------------- #
    #                                      end                                     #
    # ---------------------------------------------------------------------------- #
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="playerctl"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="playerctl"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="playerctl"),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl s 5%+"),
        desc="brightness UP",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl s 5%-"),
        desc="brightness Down",
    ),
    # ---------------------------------------------------------------------------- #
    #                                    Launch                                    #
    # ---------------------------------------------------------------------------- #
    Key([mod], "e", lazy.spawn("nemo"), desc="file manager"),
    Key([mod], "b", lazy.spawn("thorium-browser"), desc="thorium"),
    Key([mod], "c", lazy.spawn("code"), desc="vscode"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="rofi"),
    Key([alt], "tab", lazy.spawn("rofi -show window"), desc="rofi window"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # ---------------------------------------------------------------------------- #
    #                                  Screenshot                                  #
    # ---------------------------------------------------------------------------- #
    Key([mod, "shift"], "s", lazy.spawn(home + "/.config/qtile/scripts/screenshot.sh")),
]


# ---------------------------------------------------------------------------- #
#                                    Groups                                    #
# ---------------------------------------------------------------------------- #


groups = [Group(f"{i+1}", label="") for i in range(8)]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

# ---------------------------------------------------------------------------- #
#                                    Layouts                                   #
# ---------------------------------------------------------------------------- #

layout_theme = {
    "border_width": 2,
    "margin": 12,
    "border_focus": "#d4be98",
    "border_normal": "#24273A",
    "single_border_width": 3,
}

layouts = [
    # Tiling Layouts
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    # Fullscreen Layout
    layout.Max(**layout_theme),
    layout.Floating(),
]


widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = [widget_defaults.copy()]


# ---------------------------------------------------------------------------- #
#                                      Bar                                     #
# ---------------------------------------------------------------------------- #

screens = [Screen()]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#1F1D2E",
    border_normal="#1F1D2E",
    border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="xdm-app"),
        Match(wm_class="Xdman"),
        Match(wm_class="Xdman-Main"),
        Match(wm_class="xdman-Main"),
        Match(wm_class="blueman-manager"),
        Match(title="XDM 2020"),
        Match(title="java-lang-Thread"),
        Match(title="mpv"),
        Match(title="Mission Center"),
        Match(wm_class="java-lang-Thread"),
        # Match(title=re.compile(r"^(Open File)(.*)$")),
        # Match(title=re.compile(r"^(Select a File)(.*)$")),
        # Match(title=re.compile(r"^(Choose wallpaper)(.*)$")),
        # Match(title=re.compile(r"^(Open Folder)(.*)$")),
        # Match(title=re.compile(r"^(Save As)(.*)$")),
        # Match(title=re.compile(r"^(Library)(.*)$")),
        # Match(title=re.compile(r"^(File Upload)(.*)$")),
        # Match(title=re.compile(r"^(.*)(wants to save)$")),
        # Match(title=re.compile(r"^(.*)(wants to open)$")),
    ],
)


# stuff
@hook.subscribe.startup_once
def autostart():
    # subprocess.call([os.path.expanduser(".config/qtile/autostart_once.sh")])
    autostartscript = "~/.config/qtile/autostart_once.sh"
    home = os.path.expanduser(autostartscript)
    subprocess.Popen([home])


from libqtile import hook


@hook.subscribe.client_new
def center_floating(window):
    if window.floating:
        window.center()


auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "QTILE"
