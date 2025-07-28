set fish_greeting

function starship_transient_prompt_func
	echo -n ' '
	starship module directory
	starship module character
end

starship init fish | source
enable_transience

zoxide init --cmd cd fish | source

thefuck --alias fuck | source

pyenv init - fish | source

# Created by `pipx` on 2025-07-17 18:00:28
set PATH $PATH /home/tyler/.local/bin

# fastfetch --logo $HOME/.config/fastfetch/archlogo.png
