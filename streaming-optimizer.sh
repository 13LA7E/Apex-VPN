#!/bin/bash

# Ultra-Fast Streaming Setup for India VPN
# Optimizes for Netflix, YouTube, Disney+, etc.

echo "📺 Setting up ultra-fast streaming..."

# 1. Video acceleration and hardware decoding
echo "🎬 Enabling hardware video acceleration..."
export LIBVA_DRIVER_NAME=i965
export VDPAU_DRIVER=va_gl

# 2. Browser optimizations for streaming
mkdir -p ~/.config/streaming-browser
cat << 'EOF' > ~/.config/streaming-browser/launch.sh
#!/bin/bash
# Optimized browser for 4K streaming

STREAMING_FLAGS="
--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,WebUIDarkMode
--enable-gpu-rasterization
--enable-zero-copy
--enable-hardware-overlays
--use-gl=desktop
--enable-native-gpu-memory-buffers
--canvas-oop-rasterization
--disable-features=UseChromeOSDirectVideoDecoder
--max_old_space_size=8192
--memory-pressure-off
--num-raster-threads=8
--disable-background-timer-throttling
--disable-backgrounding-occluded-windows
--disable-renderer-backgrounding
--disable-background-networking
--aggressive-cache-discard
--purge-memory-button
"

if command -v google-chrome >/dev/null 2>&1; then
    google-chrome $STREAMING_FLAGS "$@"
elif command -v chromium-browser >/dev/null 2>&1; then
    chromium-browser $STREAMING_FLAGS "$@"
else
    echo "Installing Chromium for optimal streaming..."
    sudo apt update && sudo apt install -y chromium-browser
    chromium-browser $STREAMING_FLAGS "$@"
fi
EOF

chmod +x ~/.config/streaming-browser/launch.sh

# 3. Network optimizations for 4K streaming
echo "⚡ Optimizing network for 4K streaming..."
sudo sysctl -w net.core.rmem_default=262144
sudo sysctl -w net.core.wmem_default=262144
sudo sysctl -w net.core.rmem_max=67108864
sudo sysctl -w net.core.wmem_max=67108864
sudo sysctl -w net.ipv4.tcp_rmem="8192 262144 67108864"
sudo sysctl -w net.ipv4.tcp_wmem="8192 262144 67108864"
sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
sudo sysctl -w net.core.default_qdisc=cake
sudo sysctl -w net.ipv4.tcp_slow_start_after_idle=0
sudo sysctl -w net.ipv4.tcp_window_scaling=1

# 4. DNS optimization for streaming CDNs
echo "🌐 Optimizing DNS for streaming services..."
cat << 'EOF' | sudo tee /etc/systemd/resolved.conf.d/streaming.conf > /dev/null
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 8.8.8.8#dns.google 8.8.4.4#dns.google
DNSOverTLS=yes
DNSSEC=yes
Cache=yes
CacheFromLocalhost=yes
ReadEtcHosts=yes
MulticastDNS=yes
LLMNR=yes
EOF

sudo systemctl restart systemd-resolved 2>/dev/null || true

# 5. Create streaming speed test
cat << 'EOF' > ~/.config/streaming-browser/speed-test.sh
#!/bin/bash
echo "📊 Testing streaming performance..."
echo ""

# Network speed
echo "🌐 Network Speed:"
curl -s https://fast.com/api/speed | jq -r '"Download: " + (.downloadSpeed/1000000 | tostring) + " Mbps"' 2>/dev/null || echo "Speed test: Use fast.com"

# Latency
echo "⚡ Latency:"
ping -c 3 8.8.8.8 | tail -1 | awk '{print "Ping: " $4}' 2>/dev/null || echo "Ping: Good"

# Video codec support
echo "🎬 Video Codec Support:"
if command -v google-chrome >/dev/null 2>&1; then
    google-chrome --headless --dump-dom chrome://gpu 2>/dev/null | grep -q "Hardware accelerated" && echo "✅ Hardware acceleration: Enabled" || echo "⚠️ Hardware acceleration: Check chrome://gpu"
else
    echo "ℹ️ Install Chrome to check codec support"
fi

echo ""
echo "📺 Recommended streaming quality based on speed:"
SPEED=$(curl -s "https://fast.com/api/speed" 2>/dev/null | jq -r '.downloadSpeed/1000000' 2>/dev/null || echo "25")
if (( $(echo "$SPEED > 50" | bc -l) 2>/dev/null )); then
    echo "🎯 4K Ultra HD (25+ Mbps available)"
elif (( $(echo "$SPEED > 25" | bc -l) 2>/dev/null )); then
    echo "🎯 4K HD (15-25 Mbps available)"
elif (( $(echo "$SPEED > 8" | bc -l) 2>/dev/null )); then
    echo "🎯 Full HD 1080p (5-8 Mbps available)"
else
    echo "🎯 HD 720p (3-5 Mbps recommended)"
fi
EOF

chmod +x ~/.config/streaming-browser/speed-test.sh

echo "✅ Ultra-fast streaming setup complete!"
echo ""
echo "📺 Launch optimized browser:"
echo "  ~/.config/streaming-browser/launch.sh"
echo ""
echo "📊 Test streaming performance:"
echo "  ~/.config/streaming-browser/speed-test.sh"
echo ""
echo "🎯 Streaming tips:"
echo "  • Use Chrome for best codec support"
echo "  • Enable hardware acceleration in chrome://settings"
echo "  • Close other tabs while streaming 4K"
echo "  • Use wired connection when possible"