#!/bin/bash

# Disable spotlight
sudo mdutil -i off -a

# Install Google Chrome
brew install --cask google-chrome

# Install Chrome Remote Desktop
curl -L "https://dl.google.com/chrome-remote-desktop/chromeremotedesktop.dmg" -o /tmp/crd.dmg
sudo hdiutil attach /tmp/crd.dmg
sudo installer -pkg "/Volumes/Chrome Remote Desktop/ChromeRemoteDesktop.pkg" -target /
sudo hdiutil detach "/Volumes/Chrome Remote Desktop"

# Run the auth command from secret
eval "$1"

sleep 5
echo "================================"
echo "Chrome Remote Desktop quruldu!"
echo "remotedesktop.google.com-a gir"
echo "================================"
