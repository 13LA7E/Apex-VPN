#!/bin/bash
# Manual Auto-Start Setup for APEX VPN
# Run this script to add APEX VPN auto-start to your shell profile

echo "🏔️ Setting up APEX VPN Manual Auto-Start..."

# Create the auto-start command
AUTOSTART_CMD='
# APEX VPN Auto-Start
if [ -f "/workspaces/Apex-VPN/apex-vpn" ] && [ ! -f "/tmp/apex-started" ]; then
    echo "⚡ APEX VPN auto-starting..."
    touch /tmp/apex-started
    (cd /workspaces/Apex-VPN && nohup ./auto-start.sh > /tmp/manual-autostart.log 2>&1 &)
fi
'

# Add to .bashrc if it doesn't already exist
if ! grep -q "APEX VPN Auto-Start" ~/.bashrc 2>/dev/null; then
    echo "$AUTOSTART_CMD" >> ~/.bashrc
    echo "✅ Added APEX VPN auto-start to ~/.bashrc"
else
    echo "ℹ️ APEX VPN auto-start already exists in ~/.bashrc"
fi

# Add to .zshrc if it exists and doesn't already have it
if [ -f ~/.zshrc ] && ! grep -q "APEX VPN Auto-Start" ~/.zshrc 2>/dev/null; then
    echo "$AUTOSTART_CMD" >> ~/.zshrc
    echo "✅ Added APEX VPN auto-start to ~/.zshrc"
fi

echo ""
echo "🎯 Manual auto-start setup complete!"
echo "💡 This will ensure APEX VPN starts automatically when you open a terminal"
echo "🔄 Run 'source ~/.bashrc' or restart your terminal to activate"
echo ""
echo "📝 To test: ./apex-vpn ready"