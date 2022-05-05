xsetroot -cursor_name left_ptr &
eval $(/usr/bin/gnome-keyring-daemon --start) &
export SSH_AUTH_SOCK &
udiskie &
exec bspwm &
exec sxhkd
