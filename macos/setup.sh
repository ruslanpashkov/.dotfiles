#!/bin/bash

    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
