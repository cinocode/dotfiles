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
ensurePackageInstalled ranger
ensurePackageInstalled squid
ensurePackageInstalled zsh
ensurePackageInstalled yadm
ensurePackageInstalled grep

ensureCaskInstalled font-inconsolata
ensureCaskInstalled font-fontawesome
ensureCaskInstalled font-fira-code

ensureCaskInstalled google-chrome
ensureCaskInstalled intellij-idea

sudo chmod 755 /usr/local/share/zsh
sudo chmod 755 /usr/local/share/zsh/site-functions
