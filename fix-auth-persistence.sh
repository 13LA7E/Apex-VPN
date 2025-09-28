#!/bin/bash
# APEX VPN Authentication Persistence Fix
# This script permanently fixes the Tailscale logout issues

echo "🔧 APEX VPN Authentication Persistence Fix"
echo "==========================================="
echo ""

# Kill any running tailscale processes
echo "⏹️ Stopping all Tailscale processes..."
sudo tailscale down 2>/dev/null || true
sudo pkill -9 tailscaled 2>/dev/null || true
sleep 2

# Clean up old state and create fresh persistent state
echo "🧹 Cleaning up authentication state..."
sudo rm -rf /home/vscode/.tailscale-state
sudo mkdir -p /home/vscode/.tailscale-state
sudo chown -R vscode:vscode /home/vscode/.tailscale-state
sudo chmod -R 700 /home/vscode/.tailscale-state

# Create persistent socket directory
echo "🔌 Setting up persistent socket..."
sudo mkdir -p /var/run/tailscale
sudo chmod 777 /var/run/tailscale

echo "✅ Authentication persistence setup complete!"
echo ""
echo "🚀 Now run: ./apex-vpn start"
echo "   After authentication, your login will persist across restarts"