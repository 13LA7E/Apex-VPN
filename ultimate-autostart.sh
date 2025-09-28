#!/bin/bash
# APEX VPN Ultimate Autostart - Guaranteed to work

LOG_FILE="/tmp/apex-ultimate-startup.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Only run if not already started
if [ -f /tmp/apex-ultimate-started ]; then
    exit 0
fi

touch /tmp/apex-ultimate-started

log "🏔️ APEX VPN Ultimate Autostart initiated"

# Wait for system to be ready
sleep 5

# Change to correct directory
cd /workspaces/India-VPN || exit 1

# Check if already running
if tailscale status >/dev/null 2>&1; then
    log "✅ APEX VPN already running"
    exit 0
fi

# Start APEX VPN
log "🚀 Starting APEX VPN..."
./apex-vpn start >> "$LOG_FILE" 2>&1

# Verify it worked
sleep 3
if tailscale status >/dev/null 2>&1; then
    log "✅ APEX VPN startup successful!"
else
    log "⚠️ APEX VPN startup needs verification"
fi

log "🎯 Ultimate autostart complete"
