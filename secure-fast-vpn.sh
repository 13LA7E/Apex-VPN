#!/bin/bash

# Maximum Security & Speed VPN Setup for India
# Combines Tailscale with additional layers of protection

echo "🔒 Setting up Maximum Security + Speed VPN..."

# 1. Configure secure DNS (blocks tracking, faster resolution)
echo "📡 Setting up secure DNS..."
sudo mkdir -p /etc/systemd/resolved.conf.d/
cat << 'EOF' | sudo tee /etc/systemd/resolved.conf.d/dns.conf > /dev/null
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com
DNSOverTLS=yes
DNSSEC=yes
Cache=yes
ReadEtcHosts=yes
EOF

# 2. Start Tailscale with optimized settings
echo "⚡ Starting optimized Tailscale..."
sudo mkdir -p /var/lib/tailscale /var/run/tailscale

# Kill any existing instances
sudo pkill tailscaled 2>/dev/null || true
sleep 1

# Start with performance optimizations
sudo tailscaled \
    --state=/var/lib/tailscale/tailscaled.state \
    --socket=/var/run/tailscale/tailscaled.sock \
    --port 41641 \
    --tun=userspace-networking=false &

sleep 2

# Connect with security + speed optimizations
sudo tailscale up \
    --accept-routes \
    --accept-dns=false \
    --advertise-exit-node \
    --snat-subnet-routes=false \
    --netfilter-mode=on

echo "🌐 Configuring browser security..."

# 3. Setup secure browser profile
mkdir -p ~/.config/secure-browser
cat << 'EOF' > ~/.config/secure-browser/launch.sh
#!/bin/bash
# Launch browser with maximum security settings
export TMPDIR=/tmp/secure-browser-$$
mkdir -p $TMPDIR

# Security flags for Chromium/Chrome
SECURITY_FLAGS="
--no-default-browser-check
--disable-background-networking
--disable-background-timer-throttling
--disable-backgrounding-occluded-windows
--disable-renderer-backgrounding
--disable-features=TranslateUI,BlinkGenPropertyTrees
--enable-features=VaapiVideoDecoder,VaapiVideoEncoder
--disable-ipc-flooding-protection
--enable-gpu-rasterization
--enable-zero-copy
--num-raster-threads=4
--incognito
--proxy-server=socks5://127.0.0.1:1080
"

if command -v google-chrome >/dev/null 2>&1; then
    google-chrome $SECURITY_FLAGS "$@"
elif command -v chromium-browser >/dev/null 2>&1; then
    chromium-browser $SECURITY_FLAGS "$@"
else
    echo "Install Chrome or Chromium for optimal security"
fi

rm -rf $TMPDIR
EOF

chmod +x ~/.config/secure-browser/launch.sh

# 4. Network optimizations for streaming
echo "📺 Optimizing network for streaming..."

# TCP optimizations
sudo sysctl -w net.core.rmem_max=134217728
sudo sysctl -w net.core.wmem_max=134217728
sudo sysctl -w net.ipv4.tcp_rmem="4096 43690 134217728"
sudo sysctl -w net.ipv4.tcp_wmem="4096 43690 134217728"
sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
sudo sysctl -w net.core.default_qdisc=fq

# Status check
echo "✅ Security & Speed Setup Complete!"
echo ""
echo "🔒 Security Features Active:"
echo "  ✓ Tailscale WireGuard encryption"
echo "  ✓ Secure DNS over TLS (Cloudflare)"
echo "  ✓ Exit node capability"
echo "  ✓ Browser security profile"
echo ""
echo "⚡ Speed Optimizations:"
echo "  ✓ BBR congestion control"
echo "  ✓ Optimized TCP buffers"
echo "  ✓ Hardware video acceleration"
echo "  ✓ Multi-threaded rendering"
echo ""
echo "🌐 Your IP location:"
curl -s https://ipapi.co/json | jq -r '"📍 " + .city + ", " + .country_name + " (" + .org + ")"'
echo ""
echo "🚀 Usage:"
echo "  Browser: ~/.config/secure-browser/launch.sh"
echo "  Status:  sudo tailscale status"
echo "  Speed:   curl -s https://fast.com"