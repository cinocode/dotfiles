#!/bin/zsh
source ~/.config/dots/java8home.sh

export EDITOR=/usr/bin/vim
export ZSH="/opt/oh-my-zsh"
ZSH_THEME="kolo_custom"
DISABLE_AUTO_UPDATE="true"
source ${ZSH}/oh-my-zsh.sh
plugins=(git)

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
alias mcp="JAVA_HOME=${JAVA11_HOME} mvn -T 1.1C clean package -Dmaven.test.skip=true"
alias mcp8="JAVA_HOME=${JAVA8_HOME} mvn -T 1.1C clean package -Dmaven.test.skip=true"
alias msb="JAVA_HOME=${JAVA11_HOME} mvn -T 1.1C spring-boot:run"
alias msb8="JAVA_HOME=${JAVA8_HOME} mvn -T 1.1C spring-boot:run"
alias mct="JAVA_HOME=${JAVA11_HOME} mvn test"
alias mcr="JAVA_HOME=${JAVA11_HOME} mvn spring-boot:run"

alias n='vim ~/note/orga/scram.txt'
alias t="trash-put $@"
alias squid_manage="sudo systemctl restart squid && lht_squid_manage"

if [[ -d /usr/local/opt/java11 ]]; then
    JAVA_EXEC=/usr/local/opt/java11
else
    JAVA_EXEC=/usr/lib/jvm/java11-openjdk
fi
alias tscs="TS_NODE_COMPILER_OPTIONS='{\"strict\": true}' ts-node"
alias tscl="ts-node"
alias jsc="node"
alias j11="${JAVA_EXEC}/bin/jshell"
alias ktl="JAVA_HOME=${JAVA_EXEC} kotlinc-jvm -Djava.awt.headless=false"

alias dockerprox="sudoedit /etc/systemd/system/docker.service.d/10_docker_proxy.conf"
alias dcu="sudo docker-compose up -d"
alias dcfu="docker_fresh && sudo docker-compose up -d"
alias dcd="sudo docker-compose down"
alias dcr="sudo docker-compose down && sudo docker-compose up -d"

alias ktformat='ktlint -F "src/**/*.kt"'
alias ktpr='pretty && ktformat'

# alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
# alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
# alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'

alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias free='free -m'                      # show sizes in MB

alias mpv="mpv --sid=no"

alias raspi='source ~/.bin/id_keychain.sh && ssh pi@192.168.1.181'
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

alias ttvip='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key ttvip@rlx-v772.ham.dlh.de'
alias ntvip='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key ntvip@rlx-v772.ham.dlh.de'
alias htvip='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key htvip@rlx-v772.ham.dlh.de'

alias tpvip='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key tpvip@rlx-v773.ham.dlh.de'
alias npvip='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key npvip@rlx-v773.ham.dlh.de'
alias hpvip='source ~/.bin/lh_keychain.sh && ssh -i .ssh/lh_ssh_key hpvip@rlx-v773.ham.dlh.de'

# PLW
# tepw6@rlx-v271.ham.dlh.de
# tkpw6@rlx-v273.ham.dlh.de
# tppw6@rlx-v328.ham.dlh.de
# tppw6@rlx-v537.ham.dlh.de

export TERM="xterm-256color"
setopt autocd # assume "cd" when a command is a directory

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

export http_proxy="http://localhost:3128"
export https_proxy="http://localhost:3128"

function proxy_on() {
    proxy_vars_up
    source ~/.config/dots/zshrc.local
    echo -e "PROXY ON"
}

function proxy_off(){
    proxy_vars_down
    source ~/.config/dots/zshrc.local
    echo -e "PROXY OFF"
}

oc_not_found=$(which oc | grep 'not found')
if [ -z $oc_not_found ]; then
    source <(oc completion zsh)
fi
