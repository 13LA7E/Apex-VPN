#!/bin/bash
# APEX VPN Auto-Start Script v1.0
# Automatically starts APEX VPN when codespace opens

LOG_FILE="/tmp/vpn-startup.log"
CODESPACE_LOG="/tmp/codespace-startup.log"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE" "$CODESPACE_LOG"
}

log_message "⚡ APEX VPN Auto-Start Initiated"
log_message "🔍 Checking environment..."

# Check if we're in the right directory
cd /workspaces/India-VPN 2>/dev/null || {
    log_message "❌ Failed to change to VPN directory"
    exit 1
}

# Check if the main script exists
if [ ! -x "./india-vpn" ]; then
    log_message "❌ APEX VPN script not found or not executable"
    exit 1
fi

log_message "✅ Environment check passed"
log_message "🚀 Starting APEX VPN in background..."

# Start VPN in background with proper error handling
{
    sleep 3  # Give system time to fully initialize
    log_message "🏔️ Launching APEX VPN..."
    ./india-vpn start 2>&1 | tee -a "$LOG_FILE"
    
    if [ $? -eq 0 ]; then
        log_message "✅ APEX VPN reached summit successfully!"
    else
        log_message "⚠️ APEX VPN encountered issues during startup"
    fi
    
    log_message "📊 Final status check..."
    ./india-vpn ready 2>&1 | tee -a "$LOG_FILE"
    
} &

log_message "🎯 APEX VPN auto-start process initiated in background"
log_message "📝 Monitor progress: tail -f $LOG_FILE"
log_message "🔍 Check status anytime: ./india-vpn ready"

exit 0