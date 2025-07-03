
SCHEME='prefer-dark'
THEME='adw-gtk3-dark'
ICONS='Adwaita'
CURSOR='Bibata-Modern-Ice'
FONT='JetBrainsMono Nerd Font 11'

SCHEMA='gsettings set org.gnome.desktop.interface'

apply_themes() {
    ${SCHEMA} color-scheme "$SCHEME"
    ${SCHEMA} gtk-theme "$THEME"
    ${SCHEMA} icon-theme "$ICONS"
    ${SCHEMA} cursor-theme "$CURSOR"
    ${SCHEMA} font-name "$FONT"
}

apply_themes
