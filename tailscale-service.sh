#!/bin/bash

# Simple Tailscale Daemon Manager
# Keeps Tailscale running in the background

PIDFILE="/tmp/tailscale-daemon.pid"
LOGFILE="/tmp/tailscale-daemon.log"

start_daemon() {
    if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
        echo "Tailscale daemon is already running (PID: $(cat $PIDFILE))"
        return 0
    fi
    
    echo "Starting Tailscale daemon..."
    
    # Create directories
    sudo mkdir -p /var/lib/tailscale /var/run/tailscale
    
    # Start tailscaled in background
    nohup sudo tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock > "$LOGFILE" 2>&1 &
    
    echo $! > "$PIDFILE"
    echo "Tailscale daemon started (PID: $!)"
    
    # Wait a bit for daemon to initialize
    sleep 3
    
    # Connect to network
    echo "Connecting to Tailscale network..."
    if sudo tailscale status > /dev/null 2>&1; then
        echo "Already connected to Tailscale"
    else
        echo "Note: You may need to authenticate manually with 'sudo tailscale up'"
    fi
}

stop_daemon() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "Stopping Tailscale daemon (PID: $PID)..."
            kill "$PID"
            rm -f "$PIDFILE"
            echo "Tailscale daemon stopped"
        else
            echo "Tailscale daemon not running"
            rm -f "$PIDFILE"
        fi
    else
        echo "No PID file found"
    fi
}

status() {
    if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
        echo "Tailscale daemon is running (PID: $(cat $PIDFILE))"
        echo "Tailscale status:"
        sudo tailscale status 2>/dev/null || echo "Not connected"
    else
        echo "Tailscale daemon is not running"
    fi
}

case "$1" in
    start)
        start_daemon
        ;;
    stop)
        stop_daemon
        ;;
    status)
        status
        ;;
    restart)
        stop_daemon
        sleep 2
        start_daemon
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart}"
        exit 1
        ;;
esac