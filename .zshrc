eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

source /usr/share/zsh-antidote/antidote.zsh
antidote load

alias wreset="pkill waybar && hyprctl dispatch exec waybar"
