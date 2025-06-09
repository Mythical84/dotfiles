eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

alias wreset="pkill waybar && hyprctl dispatch exec waybar"
