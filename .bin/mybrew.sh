#!/bin/bash

function ensurePackageInstalled {
  if brew info $1 | grep -q 'Not installed'; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew install $1
  fi
}

function ensureCaskInstalled {
  if brew cask info $1 | grep -q 'Not installed'; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew cask install $1
  fi
}

if ! which brew; then
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew tap homebrew/cask-fonts
  brew tap homebrew/services
  brew tap amar1729/formulae
fi

if ! which brew; then
    echo 'need homebrew'
    exit 1
fi

brew update
brew upgrade

ensurePackageInstalled openjdk@11
ensurePackageInstalled kotlin
ensurePackageInstalled git
ensurePackageInstalled git-delta
ensurePackageInstalled bat
ensurePackageInstalled maven
ensurePackageInstalled npm
ensurePackageInstalled httpie
ensurePackageInstalled prettier
ensurePackageInstalled ktlint
ensurePackageInstalled tmux
ensurePackageInstalled pass
ensurePackageInstalled pass-git-helper
ensurePackageInstalled browserpass
ensurePackageInstalled ranger
ensurePackageInstalled squid
ensurePackageInstalled zsh
ensurePackageInstalled yadm
ensurePackageInstalled grep
ensurePackageInstalled gnu-sed
ensurePackageInstalled glances
ensurePackageInstalled openshift-cli
ensurePackageInstalled stern
ensurePackageInstalled openconnect
ensurePackageInstalled keychain

ensureCaskInstalled font-inconsolata
ensureCaskInstalled font-fontawesome
ensureCaskInstalled font-fira-code
ensureCaskInstalled karabiner-elements

ensurePackageInstalled mpv

ensureCaskInstalled google-chrome
ensureCaskInstalled intellij-idea
ensureCaskInstalled iterm2

ensureCaskInstalled amethyst
# ensureCaskInstalled alfred

ensureCaskInstalled slack
ensureCaskInstalled microsoft-teams
ensureCaskInstalled microsoft-office

ensurePackageInstalled docker
ensurePackageInstalled docker-machine
ensurePackageInstalled docker-compose
ensureCaskInstalled virtualbox
# docker-machine create --driver virtualbox default
# docker-machine env default
# eval "$(docker-machine env default)"
# docker-machine stop default
#  -> VirtualBox Settings - Network - Advanced - Port Forwarading - Enter Common Ports
# docker-machine start default

sudo chmod 755 /usr/local/share/zsh
sudo chmod 755 /usr/local/share/zsh/site-functions
