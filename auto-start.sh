#!/bin/bash
echo "🚀 Ultimate India VPN auto-starting in background..."
{
    sleep 2
    /workspaces/India-VPN/india-vpn start &>/tmp/vpn-startup.log
    echo "Ultimate VPN startup completed at $(date)" >> /tmp/vpn-startup.log
} &
echo "✅ Ultimate VPN starting - check status with: ./india-vpn ready"