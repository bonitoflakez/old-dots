xsetroot -cursor_name left_ptr &
eval $(/usr/bin/gnome-keyring-daemon --start) &
export SSH_AUTH_SOCK &
udiskie &
xset m 0 0 &
exec bspwm &
exec sxhkd
