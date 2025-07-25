    
#       █████████     ███████    ███████████ █████ █████ ███████████ █████ █████       ██████████
#      ███░░░░░███  ███░░░░░███ ░█░░░░░░███ ░░███ ░░███ ░█░░░███░░░█░░███ ░░███       ░░███░░░░░█
#     ███     ░░░  ███     ░░███░     ███░   ░░███ ███  ░   ░███  ░  ░███  ░███        ░███  █ ░ 
#    ░███         ░███      ░███     ███      ░░█████       ░███     ░███  ░███        ░██████   
#    ░███         ░███      ░███    ███        ░░███        ░███     ░███  ░███        ░███░░█   
#    ░░███     ███░░███     ███   ████     █    ░███        ░███     ░███  ░███      █ ░███ ░   █
#     ░░█████████  ░░░███████░   ███████████    █████       █████    █████ ███████████ ██████████
#      ░░░░░░░░░     ░░░░░░░    ░░░░░░░░░░░    ░░░░░       ░░░░░    ░░░░░ ░░░░░░░░░░░ ░░░░░░░░░░ 
#
#                                                                                    - DARKKAL44
  


from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, hook, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder
from time import sleep

mod = "mod4"
terminal = "alacritty"

# █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █▀
# █░█ ██▄ ░█░ █▄█ █ █░▀█y █▄▀ ▄█




keys = [

#  D E F A U L T

    # focus window
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # move window
    Key([mod, "control"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "control"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "up", lazy.layout.shuffle_up(), desc="Move window up"),

    # grow/shrink window
    Key([mod, "shift"], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    
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

# C U S T O M

    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%"), desc='Volume Up'),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%"), desc='volume down'),
    Key([], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute"), desc='Volume Mute'),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc='playerctl'),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc='playerctl'),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc='playerctl'),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 10%+"), desc='brightness UP'),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-"), desc='brightness Down'),
	Key([mod], "h", lazy.spawn("roficlip"), desc='clipboard'),
    Key([mod], "s", lazy.spawn("flameshot gui"), desc='Screenshot'),
    # Key([mod], "r", lazy.spawn("sh -c ~/.config/rofi/scripts/launcher"), desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("sh -c ~/.config/rofi/scripts/power"), desc='powermenu'),
    # Key([mod], "t", lazy.spawn("sh -c ~/.config/rofi/scripts/theme_switcher"), desc='theme_switcher'),
    Key([mod], "e", lazy.spawn("nemo"), desc="Launch Nemo file manager"),
    Key([mod], "b", lazy.spawn("thorium-browser"), desc="Launch Thorium browser"), 
    Key([mod], "c", lazy.spawn("code"), desc="Launch VS Code"),

]



# █▀▀ █▀█ █▀█ █░█ █▀█ █▀
# █▄█ █▀▄ █▄█ █▄█ █▀▀ ▄█



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




# L A Y O U T S



lay_config = {
    "border_width": 0,
    "margin": 9,
    "border_focus": "3b4252",
    "border_normal": "3b4252",
    "font": "FiraCode Nerd Font",
    "grow_amount": 2,
}

layouts = [
    # layout.MonadWide(**lay_config),
    layout.Bsp(**lay_config, fair=False, border_on_single=True),
    layout.Columns(
        **lay_config,
        border_on_single=True,
        num_columns=2,
        split=False,
    ),
    # Plasma(lay_config, border_normal_fixed='#3b4252', border_focus_fixed='#3b4252', border_width_single=3),
    # layout.RatioTile(**lay_config),
    # layout.VerticalTile(**lay_config),
    # layout.Matrix(**lay_config, columns=3),
    # layout.Zoomy(**lay_config),
    # layout.Slice(**lay_config, width=1920, fallback=layout.TreeTab(), match=Match(wm_class="joplin"), side="right"),
    # layout.MonadTall(**lay_config),
    # layout.Tile(shift_windows=True, **lay_config),
    # layout.Stack(num_stacks=2, **lay_config),
    layout.Floating(**lay_config),
    layout.Max(**lay_config),
]



widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = [ widget_defaults.copy()
        ]



def search():
    qtile.cmd_spawn("rofi -show drun")

def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")




# █▄▄ ▄▀█ █▀█
# █▄█ █▀█ █▀▄



screens = [

    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=15,
                    background='#282738',
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/launch_Icon.png',
                    margin=2,
                    background='#282738',
                    mouse_callbacks={"Button1": power},
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/6.png',
                ),

                widget.GroupBox(
                    font="JetBrainsMono Nerd Font",
                    fontsize=24,
                    borderwidth=3,
                    highlight_method='block',
                    active='#CAA9E0',
                    block_highlight_text_color="#91B1F0",
                    highlight_color='#353446',
                    inactive='#282738',
                    foreground='#4B427E',
                    background='#353446',
                    this_current_screen_border='#353446',
                    this_screen_border='#353446',
                    other_current_screen_border='#353446',
                    other_screen_border='#353446',
                    urgent_border='#353446',
                    rounded=True,
                    disable_drag=True,
                ),

                widget.Spacer(
                    length=8,
                    background='#353446',
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/1.png',
                ),


                widget.CurrentLayoutIcon(
                    custom_icon_paths=["~/.config/qtile/Assets/layout"],
                    background='#353446',
                    scale=0.50,
                ),

                # widget.Image(
                #     filename='~/.config/qtile/Assets/5.png',
                # ),

                # widget.TextBox(
                #     text=" ",
                #     font="Font Awesome 6 Free Solid",
                #     fontsize=13,
                #     background='#282738',
                #     foreground='#CAA9E0',
                #     mouse_callbacks={"Button1": search},
                # ),

                # widget.TextBox(
                #     fmt='Search',
                #     background='#282738',
                #     font="JetBrainsMono Nerd Font Bold",
                #     fontsize=13,
                #     foreground='#CAA9E0',
                #     mouse_callbacks={"Button1": search},
                # ),

                widget.Image(
                    filename='~/.config/qtile/Assets/4.png',
                ),

                widget.WindowName(
                    background='#353446',
                    font="JetBrainsMono Nerd Font Bold",
                    fontsize=13,
                    empty_group_string="Desktop",
                    max_chars=130,
                    foreground='#CAA9E0',
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/3.png',
                ),

                widget.Systray(
                    background='#282738',
                    fontsize=2,
                ),

                widget.TextBox(
                    text=' ',
                    background='#282738',
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/6.png',
                    background='#353446',
                ),

                widget.TextBox(
                    text="",
                    font="Font Awesome 6 Free Solid",
                    fontsize=13,
                    background='#353446',
                    foreground='#CAA9E0',
                ),

                widget.Memory(
                    background='#353446',
                    format='{MemUsed: .0f}{mm}',
                    foreground='#CAA9E0',
                    font="JetBrainsMono Nerd Font Bold",
                    fontsize=13,
                    update_interval=5,
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/2.png',
                ),

                widget.Spacer(
                    length=8,
                    background='#353446',
                ),

                widget.TextBox(
                    text=" ",
                    font="Font Awesome 6 Free Solid",
                    fontsize=13,
                    background='#353446',
                    foreground='#CAA9E0',
                ),

                # widget.Battery(
                #     font="JetBrainsMono Nerd Font Bold",
                #     fontsize=13,
                #     background='#353446',
                #     foreground='#CAA9E0',
                #     format='{percent:2.0%}',
                # ),

                # widget.Image(
                #     filename='~/.config/qtile/Assets/2.png',
                # ),

                widget.Spacer(
                    length=8,
                    background='#353446',
                ),

                widget.TextBox(
                    text=" ",
                    font="Font Awesome 6 Free Solid",
                    fontsize=13,
                    background='#353446',
                    foreground='#CAA9E0',
                ),

				widget.Volume(
					font="JetBrainsMono Nerd Font Bold",
					fontsize=13,
                    background='#353446',
                    foreground='#CAA9E0',
					mute_command="pamixer --toggle-mute",
					volume_up_command="pamixer -i 5",
					volume_down_command="pamixer -d 5",
					get_volume_command="pamixer --get-volume-human",
					update_interval=0.2,
					unmute_format="{volume}%",
					mute_format="M",
				),

                widget.Image(
                    filename='~/.config/qtile/Assets/5.png',
                    background='#353446',
                ),

                widget.TextBox(
                    text=" ",
                    font="Font Awesome 6 Free Solid",
                    fontsize=13,
                    background='#282738',
                    foreground='#CAA9E0',
                ),

                widget.Clock(
                    format='%I:%M %p',
                    background='#282738',
                    foreground='#CAA9E0',
                    font="JetBrainsMono Nerd Font Bold",
                    fontsize=13,
                ),

                widget.Spacer(
                    length=18,
                    background='#282738',
                ),

            ],
            30,
            border_color='#282738',
            border_width=[0,0,0,0],
            margin=[15,60,6,60],

        ),
    ),
]



# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
	border_focus='#1F1D2E',
	border_normal='#1F1D2E',
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
    ]
)




import os
import subprocess
# stuff
@hook.subscribe.startup_once
def autostart():
    subprocess.call([os.path.expanduser('.config/qtile/autostart_once.sh')])

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
