#!/usr/bin/env bash

set -eu

# Check for clean repo status. Prevent macOS from installing the command line utilities, brew will install them without user interaction.
if [ -x "$(command -v git)" ]; then
    if [[ -n $(git status --porcelain) ]]; then
        echo "Ensure that your git status is clean and rerun this script." >&2
        exit 1
    fi
fi

# Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install tools and apps with brew bundle
brew update
brew tap homebrew/bundle
brew bundle
brew cleanup

# Install ruby via rbenv and use it globaly
if [[ $(rbenv global) != "2.6.5" ]]; then
    rbenv install 2.6.5
    rbenv global 2.6.5
fi

# Install various gems
~/.rbenv/shims/gem install cocoapods fastlane --no-document
~/.rbenv/shims/gem cleanup

# Install Oh My Zsh
if ! [ -e "$HOME/.oh-my-zsh" ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
fi

# Create and update symlinks
source symlinks.sh

# Apply macOS and settings for some apps
source settings.sh

# Install package control for Sublime Text 3
PACKAGE_COTROL_PATH="$HOME/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"
if ! [ -e "$PACKAGE_COTROL_PATH" ]; then
    curl "https://packagecontrol.io/Package%20Control.sublime-package" --create-dirs -o "$PACKAGE_COTROL_PATH"
fi

echo "###############################################################################"
echo "# Don't move or delete this repository.                                       #"
echo "# The dotfiles and app settings are symlinked to content of this repository.  #"
echo "#                                                                             #"
echo "# Please restart your computer to take effect of the applied changes.         #"
echo "###############################################################################"
