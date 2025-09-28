#!/bin/bash
# APEX VPN Auto-Start Script v1.0

LOG_FILE="/tmp/vpn-startup.log"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_message "⚡ APEX VPN Auto-Start Initiated"
log_message "🔍 Checking environment..."

# Change to VPN directory
if ! cd /workspaces/India-VPN; then
    log_message "❌ Failed to change to VPN directory"
    exit 1
fi

# Check if the main script exists
if [ ! -x "./apex-vpn" ]; then
    log_message "❌ APEX VPN script not found or not executable"
    exit 1
fi

log_message "✅ Environment check passed"
log_message "🚀 Starting APEX VPN in background..."

# Start VPN in background
{
    sleep 3
    log_message "🏔️ Launching APEX VPN..."
    ./apex-vpn start 2>&1 | tee -a "$LOG_FILE"
    
    if [ $? -eq 0 ]; then
        log_message "✅ APEX VPN reached summit successfully!"
    else
        log_message "⚠️ APEX VPN encountered issues during startup"
    fi
    
    log_message "📊 Final status check..."
    ./apex-vpn ready
} &

log_message "🎯 APEX VPN auto-start process initiated in background"
log_message "📝 Monitor progress: tail -f $LOG_FILE"
log_message "🔍 Check status anytime: ./apex-vpn ready"

exit 0
