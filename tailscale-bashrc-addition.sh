# Tailscale Auto-Start Configuration
# Add this to your ~/.bashrc or create as a separate file

# Function to start Tailscale automatically
start_tailscale_auto() {
    if [ -f "/workspaces/India-VPN/start-tailscale.sh" ]; then
        echo "🚀 Auto-starting Tailscale..."
        /workspaces/India-VPN/start-tailscale.sh
    fi
}

# Auto-start Tailscale when opening a new terminal (optional)
# Uncomment the line below if you want it to start every time you open a terminal
# start_tailscale_auto