#!/bin/bash
# APEX VPN - Pure GitHub Codespaces Setup (No Docker!)
# Run this once when creating a new codespace

echo "🏔️ Setting up APEX VPN for GitHub Codespaces (Docker-Free!)"
echo "============================================================"

# Install Tailscale
echo "📥 Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sudo sh

# Set up permissions
echo "🔧 Setting up permissions..."
chmod +x /workspaces/India-VPN/apex-vpn
chmod +x /workspaces/India-VPN/auto-start.sh
chmod +x /workspaces/India-VPN/ultimate-autostart.sh

# Create persistent state directory
echo "💾 Setting up persistent authentication..."
sudo mkdir -p /home/vscode/.tailscale-state
sudo chown -R vscode:vscode /home/vscode/.tailscale-state

# Add autostart to shell profile if not already there
if ! grep -q "APEX VPN Ultimate Autostart" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# APEX VPN Ultimate Autostart - Docker-Free!" >> ~/.bashrc
    echo "if [ -f /workspaces/India-VPN/ultimate-autostart.sh ]; then" >> ~/.bashrc
    echo "    nohup bash /workspaces/India-VPN/ultimate-autostart.sh >/dev/null 2>&1 &" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    echo "✅ Autostart added to shell profile"
else
    echo "✅ Autostart already configured"
fi

echo ""
echo "🎉 APEX VPN setup complete!"
echo "🚀 Run: ./apex-vpn start"
echo "🔄 Or just restart your terminal for autostart"
