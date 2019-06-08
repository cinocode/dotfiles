#!/bin/zsh
export EDITOR=/usr/bin/vim

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias r="ranger $@"
alias n='vim ~/note/orga/scram.txt'

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'

alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias free='free -m'                      # show sizes in MB

alias raspi='ssh pi@192.168.1.181'
alias media='ssh media@192.168.1.181'

alias vipapps='lh_keychain.sh && ssh -i .ssh/lh_ssh_key vipapps@rlx-v138.ham.dlh.de'
alias cpvipapp='lh_keychain.sh && ssh -i .ssh/lh_ssh_key cpvipapp@rlx-v138.ham.dlh.de'
alias tpvipapp='lh_keychain.sh && ssh -i .ssh/lh_ssh_key tpvipapp@rlx-v138.ham.dlh.de'
alias hpvipapp='lh_keychain.sh && ssh -i .ssh/lh_ssh_key hpvipapp@rlx-v138.ham.dlh.de'
alias patricias='lh_keychain.sh && ssh -i .ssh/lh_ssh_key patricia@rlx-v138.ham.dlh.de'

alias vipappst='lh_keychain.sh && ssh -i .ssh/lh_ssh_key vipapps@rlx-v171.ham.dlh.de'
alias ctvipapp='lh_keychain.sh && ssh -i .ssh/lh_ssh_key ctvipapp@rlx-v171.ham.dlh.de'
alias ttvipapp='lh_keychain.sh && ssh -i .ssh/lh_ssh_key ttvipapp@rlx-v171.ham.dlh.de'
alias htvipapp='lh_keychain.sh && ssh -i .ssh/lh_ssh_key htvipapp@rlx-v171.ham.dlh.de'
alias patriciat='lh_keychain.sh && ssh -i .ssh/lh_ssh_key patricia@rlx-v171.ham.dlh.de'

autoload -U colors && colors

if [[ -e /usr/share/zsh/site-contrib/powerline.zsh ]]; then
	# Powerline support is enabled if available, otherwise use a regular PS1
	. /usr/share/zsh/site-contrib/powerline.zsh
	VIRTUAL_ENV_DISABLE_PROMPT=true
else
	local _path="%B%{$fg[green]%}%(8~|...|)%7~"
	local _prompt="%{$fg[white]%}${(r:$SHLVL*1::%#:)}"

	PROMPT="$_path$_prompt "
fi

setopt autocd # assume "cd" when a command is a directory
export TERM="xterm-256color"

if command -V dircolors >/dev/null 2>&1; then
	eval "$(dircolors -b)"
	# Only alias ls colors if dircolors is installed
	alias ls="ls -F --color=auto"
	alias dir="dir --color=auto"
	alias vdir="vdir --color=auto"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ole/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
unset SSH_ASKPASS

stty -ixon

source ~/.config/dots/zshrc.local

function proxy_on() {
    source ~/.config/dots/proxy

    echo "export http_proxy=\"${hold_http_proxy}\"" > ~/.config/dots/zshrc.local
    echo "export no_proxy=\"${hold_no_proxy}\"" >> ~/.config/dots/zshrc.local
    echo "export https_proxy=\"${hold_http_proxy}\"" >> ~/.config/dots/zshrc.local
    echo "export ftp_proxy=\"${hold_http_proxy}\"" >> ~/.config/dots/zshrc.local
    echo "export rsync_proxy=\"${hold_http_proxy}\"" >> ~/.config/dots/zshrc.local

    cat ~/.config/dots/gitconfig.local.sample > ~/.config/dots/gitconfig.local
    echo "  proxy = ${hold_http_proxy}" >> ~/.config/dots/gitconfig.local

    source ~/.config/dots/zshrc.local
    source ~/.zshrc

    echo -e "ON"
}

function proxy_off(){
    rm ~/.config/dots/gitconfig.local
    touch ~/.config/dots/gitconfig.local
    rm ~/.config/dots/zshrc.local
    touch ~/.config/dots/zshrc.local

    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset RSYNC_PROXY

    source ~/.zshrc

    echo -e "OFF"
}
