#!/bin/bash
# MAC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN MAC_REALNAME CHROME_CODE

# Disable spotlight
sudo mdutil -i off -a

# Install Google Chrome
brew install --cask google-chrome

# Install Chrome Remote Desktop Host for Mac
curl -L https://dl.google.com/chrome-remote-desktop/chromeremotedesktop.dmg -o crd.dmg
hdiutil attach crd.dmg
sudo installer -pkg /Volumes/Chrome\ Remote\ Desktop/ChromeRemoteDesktop.pkg -target /
hdiutil detach /Volumes/Chrome\ Remote\ Desktop/

# Start Chrome Remote Desktop with auth code
/Applications/Chrome\ Remote\ Desktop\ Host.app/Contents/MacOS/chrome-remote-desktop \
  --start-host \
  --code="$5" \
  --redirect-url="https://remotedesktop.google.com/_/oauthredirect" \
  --name="GitHubMac" &

sleep 5
echo "================================"
echo "Google Remote Desktop quruldu!"
echo "remotedesktop.google.com - bura bax"
echo "================================"
