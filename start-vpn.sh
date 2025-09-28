#!/bin/bash

# Fast Tailscale startup for Codespaces
echo "🚀 Starting Tailscale VPN..."

# Check if tailscale is installed, install if not
if ! command -v tailscale &> /dev/null; then
    echo "📦 Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
fi

# Create directories if they don't exist
sudo mkdir -p /var/lib/tailscale /var/run/tailscale

# Start tailscaled daemon if not running
if ! pgrep tailscaled > /dev/null; then
    echo "🔧 Starting Tailscale daemon..."
    sudo tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
    sleep 2
fi

# Connect to Tailscale
echo "🔗 Connecting to Tailscale..."
sudo tailscale up --accept-routes --accept-dns

# Show status
echo "✅ Tailscale Status:"
sudo tailscale status

echo "🎉 VPN Ready! Your India VPN is now active."