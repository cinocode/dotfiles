#!/bin/zsh
source ~/.config/dots/java_home.sh

export EDITOR=/usr/bin/vim
export ZSH="/opt/oh-my-zsh"
export ZSH_TMUX_FIXTERM=true
ZSH_THEME="kolo_custom"
DISABLE_AUTO_UPDATE="true"
source ${ZSH}/oh-my-zsh.sh
plugins=(git)

if [[ "$OSTYPE" == "darwin"* ]]; then
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh

    export PATH="$PATH:/Users/ole/.lmstudio/bin"
    export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
    export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

    export MUSIC_DIR="/Users/ole/Music"
else
    export MUSIC_DIR="/home/ole/music"
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias passv="PASSWORD_STORE_DIR=~/code/.vipappspass pass"

alias cat=bat
alias vi="/usr/bin/env vi"
alias vim=nvim

alias cd="z"
alias r="ranger $@"
alias rc="ranger ~/code"
alias rd="ranger ~/down"
alias rn="ranger ~/note"
alias rp="ranger ~/pic"
alias rv="ranger ~/vid"

alias cl="source ~/.bin/codelist $@"
alias mt="mvn test"
alias mcp="mvn -T 1.1C clean package -Dmaven.test.skip=true"
alias mcpt="mvn -T 1.1C clean package"

alias build="nf ci && mcpt && docker-compose up -d"
alias down="docker-compose down && mvn clean"
alias jobsk='kill -KILL ${${(v)jobstates##*:*:}%=*}'

alias n='vim ~/note/orga/inbox.txt'
alias t="trash-put $@"

alias tscs="TS_NODE_COMPILER_OPTIONS='{\"strict\": true}' ts-node"
alias tscl="ts-node"
alias ktl="kotlinc-jvm -Djava.awt.headless=false"

alias ktformat='ktlint -F "src/**/*.kt"'
alias ktpr='pretty && ktformat'

alias grep='grep --color=tty -d skip'
alias cp="cp -i" # confirm before overwriting something
alias free='free -m' # show sizes in MB

alias mpv="mpv --sid=no"

alias raspi='source ~/.bin/id_keychain.sh && ssh pi@192.168.1.181'
alias ssh_media='source ~/.bin/id_keychain.sh && ssh ole@192.168.1.172'

export TERM=screen-256color
setopt autocd # assume "cd" when a command is a directory

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v

zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

unset SSH_ASKPASS

bindkey '^R' history-incremental-search-backward

stty -ixon

if command -v oc >/dev/null 2>&1
then
    source <(oc completion zsh)
fi

if command -v bat >/dev/null 2>&1
then
    source <(ng completion script)
fi

eval "$(zoxide init zsh)"
if [[ -z $TMUX ]]; then
    exec tmux_launch
fi

source ~/.bin/id_keychain.sh
