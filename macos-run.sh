#!/bin/bash
# MAC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN MAC_REALNAME

# Disable spotlight
sudo mdutil -i off -a

# Create user
sudo dscl . -create /Users/koolisw
sudo dscl . -create /Users/koolisw UserShell /bin/bash
sudo dscl . -create /Users/koolisw RealName "$4"
sudo dscl . -create /Users/koolisw UniqueID 1001
sudo dscl . -create /Users/koolisw PrimaryGroupID 80
sudo dscl . -create /Users/koolisw NFSHomeDirectory /Users/koolisw
sudo dscl . -passwd /Users/koolisw "$1"
sudo createhomedir -c -u koolisw > /dev/null
sudo dscl . -append /Groups/admin GroupMembership koolisw

# Enable Screen Sharing (built-in, more reliable than ARD)
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
sleep 2

# Set VNC password properly
sudo defaults write /Library/Preferences/com.apple.RemoteManagement ARD_AllLocalUsers -bool true

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
  -activate -configure -access -on \
  -allowAccessFor -allUsers \
  -privs -all \
  -clientopts -setvnclegacy -vnclegacy yes \
  -clientopts -setvncpw -vncpw "$2" \
  -restart -agent -privs -all

sleep 3

# Wake up display
sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser runner
open /System/Library/CoreServices/Finder.app &
sleep 3

# Install ngrok v3
brew install ngrok/ngrok/ngrok
ngrok config add-authtoken "$3"
ngrok tcp 5900 &
sleep 5

# Print info
HOST=$(curl -s http://127.0.0.1:4040/api/tunnels | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['tunnels'][0]['public_url'].replace('tcp://',''))")
echo "================================"
echo "VNC ADDRESS: $HOST"
echo "VNC PASSWORD: $2"
echo "================================"
