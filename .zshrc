export ZSH="$HOME/.oh-my-zsh"

# More themes on: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# true/false
CASE_SENSITIVE="false"

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(
  git 
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

# aliases
alias zshconf="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias bspconf="nvim ~/.config/bspwm/bspwmrc"
alias sxhkdconf="nvim ~/.config/sxhkd/sxhkdrc"
alias alacrittyconf="nvim ~/.config/alacritty/alacritty.yml"
alias polyconf="nvim ~/.config/polybar/config"
alias picomconf="nvim ~/.config/picom/picom.conf"
alias dunstconf="nvim ~/.config/dunst/dunstrc"
alias cleantrash="sudo pacman -R $(pacman -Qtdq)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
