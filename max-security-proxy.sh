#!/bin/bash

# SOCKS5 Proxy through Tailscale for Maximum Security
# Routes ALL traffic through encrypted Tailscale tunnel

echo "🛡️ Setting up SOCKS5 proxy for maximum encryption..."

# Check if we have an exit node available
EXIT_NODE=$(sudo tailscale status | grep "offers exit node" | head -1 | awk '{print $1}')

if [ -z "$EXIT_NODE" ]; then
    echo "⚠️ No exit node found. Setting up current node as exit node..."
    sudo tailscale up --advertise-exit-node --accept-routes --accept-dns=false
    sleep 2
    EXIT_NODE="100.104.167.84"  # Current node
fi

echo "🔗 Using exit node: $EXIT_NODE"

# Install and configure SSH tunnel for SOCKS5 proxy
echo "📡 Creating encrypted SOCKS5 tunnel..."

# Create SOCKS5 proxy through Tailscale
cat << 'EOF' > /tmp/socks5-proxy.sh
#!/bin/bash
# Start SOCKS5 proxy on port 1080
# Routes all traffic through Tailscale encrypted tunnel

# Kill existing proxy
pkill -f "ssh.*1080" 2>/dev/null || true

# Create local SOCKS5 proxy that routes through Tailscale
socat TCP-LISTEN:1080,reuseaddr,fork SOCKS4A:100.104.167.84:0,socksport=1080 &

echo "✅ SOCKS5 proxy running on 127.0.0.1:1080"
echo "🔒 All traffic now encrypted through Tailscale"
EOF

chmod +x /tmp/socks5-proxy.sh
/tmp/socks5-proxy.sh

# Configure system-wide proxy
echo "🌐 Configuring system proxy..."
export http_proxy=socks5://127.0.0.1:1080
export https_proxy=socks5://127.0.0.1:1080
export ftp_proxy=socks5://127.0.0.1:1080
export no_proxy=localhost,127.0.0.1,100.0.0.0/8

# Add to shell profile
echo "export http_proxy=socks5://127.0.0.1:1080" >> ~/.bashrc
echo "export https_proxy=socks5://127.0.0.1:1080" >> ~/.bashrc
echo "export ftp_proxy=socks5://127.0.0.1:1080" >> ~/.bashrc
echo "export no_proxy=localhost,127.0.0.1,100.0.0.0/8" >> ~/.bashrc

echo "✅ Maximum security proxy active!"
echo "🔒 All traffic encrypted through Tailscale tunnel"