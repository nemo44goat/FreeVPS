#!/bin/bash

# Disable spotlight
sudo mdutil -i off -a

# Install Google Chrome
brew install --cask google-chrome

# Install Chrome Remote Desktop
curl -L "https://dl.google.com/chrome-remote-desktop/chromeremotedesktop.dmg" -o /tmp/crd.dmg
sudo hdiutil attach /tmp/crd.dmg

# Volume adını avtomatik tap
VOLUME=$(ls /Volumes | grep "Chrome Remote Desktop")
echo "Volume tapildi: $VOLUME"
sudo installer -pkg "/Volumes/$VOLUME/ChromeRemoteDesktop.pkg" -target /
sudo hdiutil detach "/Volumes/$VOLUME"

sleep 3

# Chrome Remote Desktop-u işlat
eval "$1"

sleep 5
echo "================================"
echo "Chrome Remote Desktop quruldu!"
echo "remotedesktop.google.com-a gir"
echo "================================"
