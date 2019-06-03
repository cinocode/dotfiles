export PATH=~/.bin:$PATH

export PATH=~/.npm-global/bin:$PATH

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

# Map Ctrl-S to sth usefull other than XOFF (interrupt data flow).
stty -ixon

#set sudoedit variable
export EDITOR=/usr/bin/vim
