#!/bin/bash
echo "🚀 India VPN auto-starting in background..."
{
    sleep 2
    /workspaces/India-VPN/india-vpn performance &>/tmp/vpn-startup.log
    echo "VPN startup completed at $(date)" >> /tmp/vpn-startup.log
} &
echo "✅ VPN starting - check status with: ./india-vpn ready"