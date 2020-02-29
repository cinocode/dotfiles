#!/bin/zsh
export EDITOR=/usr/bin/vim

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias passv="PASSWORD_STORE_DIR=~/code/.vipappspass pass"

alias cat=bat

alias r="ranger $@"
alias rc="ranger ~/code"
alias rd="ranger ~/down"
alias rn="ranger ~/note"
alias rp="ranger ~/pic"
alias rv="ranger ~/vid"

alias cl="source ~/.bin/codelist $@"
alias mcp="mvn clean package -Dmaven.test.skip=true"
alias mct="mvn test"
alias mcr="mvn spring-boot:run"

alias n='vim ~/note/orga/scram.txt'
alias t="trash-put $@"

alias dockerprox="sudoedit /etc/systemd/system/docker.service.d/10_docker_proxy.conf"
alias dcu="sudo docker-compose up -d"
alias dcfu="docker_fresh && sudo docker-compose up -d"
alias dcd="sudo docker-compose down"
alias dcr="sudo docker-compose down && sudo docker-compose up -d"

alias pretty='prettier --print-width 120 --single-quote --trailing-comma es5 --write "src/main/frontend/src/{app,__{tests,mocks}__}/**/*.{js,ts,html,css,scss}"'
alias ktformat='ktlint -F "src/**/*.kt"'
alias ktpr='pretty && ktformat'

alias ffeh="feh --auto-rotate -zxYN $@"
alias fehz="feh --auto-rotate -xYNZF $@"
alias fehs="feh --auto-rotate -ZzxFYND $@"
alias ffehs="feh --zoom fill --auto-rotate -zxFYND $@"
alias fehr="feh --auto-rotate -rZzxFYND $@"
alias ffehr="feh --zoom fill --auto-rotate -rzxFYND $@"

alias mpvd="mpv --af=dynaudnorm=f=75:g=10:n=0:p=0.58 Chi-Raq.2015.HDRip.XviD.Ac3-EVO.avi"
alias mpvl="mpv --af=loudnorm=I=-16:TP=-1.5:LRA=11 Chi-Raq.2015.HDRip.XviD.Ac3-EVO.avi"

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'

alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias free='free -m'                      # show sizes in MB

alias passg="diceware -n 3 -d _ | pass insert -e $@"
alias diceg="diceware -n 3 -d _"

alias raspi='source ~/.bin/id_keychain.sh && ssh ole@192.168.1.181'
alias ssh_media='source ~/.bin/id_keychain.sh && ssh ole@192.168.1.172'

alias vipapps='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key vipapps@rlx-v138.ham.dlh.de'
alias cpvipapp='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key cpvipapp@rlx-v138.ham.dlh.de'
alias tpvipapp='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key tpvipapp@rlx-v138.ham.dlh.de'
alias hpvipapp='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key hpvipapp@rlx-v138.ham.dlh.de'
alias patricias='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key patricia@rlx-v138.ham.dlh.de'

alias vipappst='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key vipapps@rlx-v171.ham.dlh.de'
alias ctvipapp='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key ctvipapp@rlx-v171.ham.dlh.de'
alias ttvipapp='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key ttvipapp@rlx-v171.ham.dlh.de'
alias htvipapp='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key htvipapp@rlx-v171.ham.dlh.de'
alias patriciat='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key patricia@rlx-v171.ham.dlh.de'
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

bindkey '^R' history-incremental-search-backward

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

    source ~/.zshrc

    echo -e "ON"
}

function proxy_off(){
    rm ~/.config/dots/gitconfig.local
    touch ~/.config/dots/gitconfig.local
    rm ~/.config/dots/zshrc.local
    touch ~/.config/dots/zshrc.local

    echo "unset http_proxy" > ~/.config/dots/zshrc.local
    echo "unset https_proxy" >> ~/.config/dots/zshrc.local
    echo "unset ftp_proxy" >> ~/.config/dots/zshrc.local
    echo "unset rsync_proxy" >> ~/.config/dots/zshrc.local
    echo "unset HTTP_PROXY" >> ~/.config/dots/zshrc.local
    echo "unset HTTPS_PROXY" >> ~/.config/dots/zshrc.local
    echo "unset FTP_PROXY" >> ~/.config/dots/zshrc.local
    echo "unset RSYNC_PROXY" >> ~/.config/dots/zshrc.local

    source ~/.zshrc

    echo -e "OFF"
}

oc_not_found=$(which oc | grep 'not found')
if [ -z $oc_not_found ]; then
    source <(oc completion zsh)
fi
