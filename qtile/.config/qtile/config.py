from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, hook, Screen, KeyChord
from libqtile.lazy import lazy


mod = "mod4"
terminal = "ghostty"

# ---------------------------------------------------------------------------- #
#                                    Keybind                                   #
# ---------------------------------------------------------------------------- #


keys = [
    #  D E F A U L T
    # Focus
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
    # Move
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
    # Swap
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "l",
        lazy.spawn("betterlockscreen -l dimblur -- --clock"),
        desc="Lock screen",
    ),
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
    Key(
        [], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute"), desc="Volume Mute"
    ),
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
    Key([mod], "e", lazy.spawn("nemo"), desc="file manager"),
    Key([mod], "b", lazy.spawn("thorium-browser"), desc="thorium"),
    Key([mod], "c", lazy.spawn("code"), desc="vscode"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="rofi"),
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
    "border_width": 3,
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


def search():
    qtile.cmd_spawn("rofi -show drun")


def power():
    qtile.cmd_spawn("sh -c ~/.config/qtile/scripts/power")


# ---------------------------------------------------------------------------- #
#                                      Bar                                     #
# ---------------------------------------------------------------------------- #

colors = {
    "bg": "#1e1e2e",
    "fg": "#cdd6f4",
    "red": "#f38ba8",
    "orange": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "blue": "#89b4fa",
    "pink": "#f5c2e7",
    "gray": "#313244",
}

font = "JetBrainsMono Nerd Font"
fontsize = 14
padding = 6

bar_widgets = [
    # === LEFT ===
    widget.TextBox(
        text="",
        font=font,
        fontsize=fontsize + 2,
        foreground=colors["blue"],
        mouse_callbacks={
            "Button1": lazy.spawn("sh -c ~/.config/qtile/scripts/wallpaper.sh")
        },
    ),
    widget.GroupBox(
        font=font,
        fontsize=fontsize,
        margin_y=3,
        margin_x=3,
        padding_y=6,
        padding_x=6,
        borderwidth=2,
        active=colors["yellow"],
        inactive=colors["gray"],
        rounded=True,
        highlight_method="block",
        highlight_color=[colors["gray"], colors["gray"]],
        this_current_screen_border=colors["orange"],
        urgent_border=colors["red"],
        disable_drag=True,
    ),
    widget.Sep(linewidth=0, padding=5),
    widget.WindowName(
        font=font,
        foreground=colors["pink"],
        max_chars=50,
    ),
    # === CENTER ===
    widget.Spacer(),  # Centering left
    widget.TextBox("", foreground=colors["pink"], font=font),
    widget.Clock(format="%a, %b %d/%m/%Y %H:%M", foreground=colors["pink"], font=font),
    widget.Spacer(),  # Centering right
    # === RIGHT ===
    widget.TextBox("", foreground=colors["red"], font=font),
    widget.CPU(
        format="{load_percent}%",
        foreground=colors["red"],
        font=font,
        update_interval=5,
    ),
    widget.TextBox("", foreground=colors["orange"], font=font),
    widget.ThermalSensor(
        # tag_sensor="Package id 0",
        format="{temp}°C",
        foreground=colors["orange"],
        font=font,
        padding=padding,
        update_interval=5,
    ),
    widget.TextBox("", foreground=colors["yellow"], font=font),
    widget.Memory(
        format="{MemUsed:.0f} GiB",
        foreground=colors["yellow"],
        font=font,
        update_interval=5,
    ),
    widget.TextBox("", foreground=colors["yellow"], font=font),
    widget.Volume(
        font=font,
        foreground=colors["yellow"],
        mute_command="pamixer --toggle-mute",
        volume_up_command="pamixer -i 5",
        volume_down_command="pamixer -d 5",
        get_volume_command="pamixer --get-volume-human",
        update_interval=0.2,
        unmute_format="{volume}%",
        mute_format="M",
    ),
    # widget.TextBox("󰈀", foreground=colors["pink"], font=font),
    # widget.Net(interface="enp3s0", format="Wired", foreground=colors["pink"], font=font),
    widget.TextBox("", foreground=colors["blue"], font=font),
    widget.Bluetooth(
        fmt="{}",
        foreground=colors["blue"],
        font=font,
        mouse_callbacks={"Button1": lazy.spawn("blueman-manager")},
    ),
    widget.TextBox("", foreground=colors["fg"], font=font),
    widget.TextBox(
        "",
        foreground=colors["red"],
        font=font,
        mouse_callbacks={
            "Button1": lambda: qtile.cmd_spawn("sh -c '~/.config/qtile/scripts/power'")
        },
    ),
]

screens = [
    Screen(
        top=bar.Bar(
            bar_widgets,
            size=30,
            background=colors["bg"],
            # padding=20,
            opacity=0.7,
            border_width=[0, 0, 0, 0],
            margin=[0, 0, 0, 0],
        )
    )
]


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
    ],
)


import os
import subprocess


# stuff
@hook.subscribe.startup_once
def autostart():
    subprocess.call([os.path.expanduser(".config/qtile/autostart_once.sh")])


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
wmname = "LG3D"


# E O F
