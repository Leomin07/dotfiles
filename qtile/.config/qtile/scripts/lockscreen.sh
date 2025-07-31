#!/bin/bash


i3lock \
  -i ~/.config/qtile/lockblur.jpg \
  --clock \
  --indicator \
  --time-str="%H:%M" \
  --date-str="%b %d/%m/%Y" \
  --inside-color=00000088 \
  --ring-color=88c0d0ff \
  --keyhl-color=81a1c1ff \
  --bshl-color=bf616aff \
  --wrong-color=ff4444ff \
  --ring-width=10 \
  --radius=120 \
  --time-color=ffffffff \
  --date-color=ffffffff \
  --time-font="JetBrainsMono Nerd Font" \
  --date-font="JetBrainsMono Nerd Font" \
  --time-size=36 \
  --date-size=20
