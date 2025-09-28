#!/bin/bash
# Ultra-fast VPN - runs in under 1 second
echo "⚡"
sudo tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &>/dev/null &
sleep 0.3
sudo tailscale up --accept-routes --accept-dns --timeout=2s &>/dev/null && echo "✅ VPN ready!" || echo "🔗 Authenticate: https://login.tailscale.com/" &