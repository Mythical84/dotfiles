eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(thefuck --alias fuck)"
echo ""

alias wreset="pkill waybar && hyprctl dispatch exec waybar"
alias clear='clear && echo ""'
alias cat=bat
alias fuck='fuck -y'

set-long-prompt() { 
	PROMPT=$(starship prompt)
}
precmd_functions=(set-long-prompt)

set-short-prompt() {
  if [[ $PROMPT != '%# ' ]]; then
		PROMPT=' $(starship module directory)$(starship module character)'
    zle .reset-prompt
  fi
}

zle-line-finish() { set-short-prompt }
zle -N zle-line-finish

trap 'set-short-prompt; return 130' INT

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#838383,bold"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath=(path/to/zsh-completions/src $fpath)
autoload -Uz compinit
rm -f ~/.zcompdump; compinit
