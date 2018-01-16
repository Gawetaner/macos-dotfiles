#!/usr/bin/env bash

set -eu

# Ask for the sudo password upfront
sudo -v

# Close "System Preferences.App" to prevent from overriding the settings
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# OSX                                                                         #
###############################################################################

# Use expanded save panel as default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable automatic closing of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable annoying smart dashes, they are not usefull if you type code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Set disk as default save target, not iCloud  
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Decrease key repeat delay and increase repeate rate
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Disable accent menu on key long press
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable auto correction
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Avoid creating .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Use dark mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark

###############################################################################
# iTunes                                                                      #
###############################################################################

# Don't start iTunes when using the media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Use current folder as default folder when performing a search
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable text selection in QuickLook
defaults write com.apple.finder QLEnableTextSelection -bool TRUE


###############################################################################
# Safari                                                                      #
###############################################################################

# Set start page
defaults write com.apple.Safari HomePage -string "about:blank"

# Avoid sending of search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Display full URL in adress bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Don't open ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable the debug menu, develop menu and Web Inspector
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Send “Do Not Track” header
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Disable auto fill for form fields
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

###############################################################################
# Desktop and Dock                                                            #
###############################################################################

# Set the desktop background image
osascript <<'APPLESCRIPT'
  tell application "System Events"
    set desktopCount to count of desktops
    repeat with desktopNumber from 1 to desktopCount
      tell desktop desktopNumber
        set picture to "/Library/Desktop Pictures/Solid Colors/Solid Gray Pro Ultra Dark.png"
      end tell
    end repeat
  end tell
APPLESCRIPT

# Move Dock to the left
defaults write com.apple.dock orientation -string "left"

# Enable auto hide
defaults write com.apple.dock autohide -bool true

# Remove auto hide delay
defaults write com.apple.Dock autohide-delay -float 0

# Adjust size of Dock icons
defaults write com.apple.dock tilesize -int 50

# Don’t animate opening applications from Dock
defaults write com.apple.dock launchanim -bool false

# Use translucent icons for hidden apps
defaults write com.apple.dock showhidden -bool true

# Only show Mail.app and Downloads in the dock.
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Mail.app"
dockutil --no-restart --add "$HOME/Downloads" --view grid --display folder

killall Dock
