#!/bin/bash
echo "⚡ APEX VPN auto-starting in background..."
{
    sleep 2
    /workspaces/India-VPN/india-vpn start &>/tmp/vpn-startup.log
    echo "APEX VPN reached summit at $(date)" >> /tmp/vpn-startup.log
} &
echo "✅ APEX VPN climbing to peak - check status with: ./india-vpn ready"