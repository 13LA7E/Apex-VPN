#!/bin/bash

# Instant Tailscale VPN - Optimized for speed
echo "⚡ Instant VPN startup..."

# Start tailscaled daemon (background, no wait)
if ! pgrep tailscaled >/dev/null; then
    sudo tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock >/dev/null 2>&1 &
fi

# Quick connect (parallel with daemon startup)
(
    sleep 0.8  # Minimal wait for daemon
    if sudo tailscale up --accept-routes --accept-dns --timeout=5s >/dev/null 2>&1; then
        echo "✅ VPN connected successfully!"
        sudo tailscale status --self=false 2>/dev/null | head -1 || echo "🌐 Connected to Tailscale network"
    else
        echo "🔗 VPN ready - authenticate at: https://login.tailscale.com/"
        echo "   Run './vpn status' after authentication"
    fi
) &

echo "🚀 VPN starting (2-3 seconds)..."
echo "🎉 Terminal ready to use immediately!"