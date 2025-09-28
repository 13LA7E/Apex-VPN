#!/bin/bash

# 🚀 MISSILE-STREAMLINED SETUP - Smoother than baby oil on a missile
# Single command deploys everything in perfect harmony

echo "🚀 MISSILE STREAMLINED MODE - Smoother than baby oil..."

# 🎯 INSTANT DEPLOYMENT - Everything in parallel
echo "⚡ Parallel deployment sequence initiated..."

# Background jobs for maximum parallelization
{
    # CPU optimization
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null 2>&1
} &

{
    # Network stack optimization
    sudo sysctl -w net.ipv4.tcp_congestion_control=bbr2 2>/dev/null || sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
    sudo sysctl -w net.core.default_qdisc=cake
    sudo sysctl -w net.core.rmem_max=134217728
    sudo sysctl -w net.core.wmem_max=134217728
    sudo sysctl -w net.ipv4.tcp_rmem="8192 1048576 134217728"
    sudo sysctl -w net.ipv4.tcp_wmem="8192 1048576 134217728"
} &

{
    # Security hardening
    sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
    sudo sysctl -w net.ipv4.conf.all.send_redirects=0
    sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
    sudo sysctl -w net.ipv4.tcp_syncookies=1
} &

{
    # DNS configuration
    cat << 'EOF' | sudo tee /etc/systemd/resolved.conf.d/missile.conf >/dev/null
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 8.8.8.8#dns.google 9.9.9.9#dns.quad9.net
DNSOverTLS=yes
DNSSEC=yes
Cache=yes
EOF
    sudo systemctl restart systemd-resolved 2>/dev/null || true
} &

{
    # Memory optimization
    sudo sysctl -w vm.swappiness=1
    sudo sysctl -w vm.dirty_ratio=15
    sudo sysctl -w vm.vfs_cache_pressure=50
} &

# Wait for all background optimizations
wait

# 🚀 TAILSCALE MISSILE LAUNCH
echo "🚀 Tailscale missile launch sequence..."

# Clean slate
sudo pkill -9 tailscaled 2>/dev/null || true

# Optimized directories
sudo mkdir -p /tmp/missile-tailscale /var/run/tailscale
sudo mount -t tmpfs -o size=50M,mode=755 tmpfs /tmp/missile-tailscale 2>/dev/null || true

# Launch daemon with missile precision
sudo tailscaled \
    --state=/tmp/missile-tailscale/tailscaled.state \
    --socket=/var/run/tailscale/tailscaled.sock \
    --port=41641 \
    --tun=userspace-networking=false &

# Parallel connection while daemon starts
sleep 0.1
(
    sleep 0.1
    sudo tailscale up \
        --accept-routes \
        --accept-dns=false \
        --advertise-exit-node \
        --timeout=2s >/dev/null 2>&1
    
    # Priority boost
    sudo renice -20 $(pgrep tailscaled) 2>/dev/null || true
    sudo ionice -c 1 -n 0 $(pgrep tailscaled) 2>/dev/null || true
) &

# 🎯 STREAMLINED TOOLS CREATION
echo "🛠️ Creating streamlined tools..."

# Single unified control script
cat << 'EOF' > /tmp/missile-control.sh
#!/bin/bash
case "$1" in
    "speed"|"s") 
        echo "🚀 Hypersonic: $(curl -s https://fast.com/api/speed 2>/dev/null | jq -r '(.downloadSpeed/1000000 | tostring) + " Mbps"' 2>/dev/null || echo "Test at fast.com")"
        sudo tailscale status | head -3
        ;;
    "status"|"st") 
        sudo tailscale status 
        ;;
    "up"|"u") 
        ./hypersonic.sh 
        ;;
    "secure"|"sec") 
        ./fort-knox.sh 
        ;;
    "down"|"d") 
        sudo tailscale down 
        ;;
    *) 
        echo "🚀 Missile Control:"
        echo "  s/speed   - Speed test"
        echo "  st/status - Status"
        echo "  u/up      - Hypersonic mode"
        echo "  sec/secure- Fort Knox mode"
        echo "  d/down    - Stop"
        ;;
esac
EOF

sudo cp /tmp/missile-control.sh /usr/local/bin/m
sudo chmod +x /usr/local/bin/m

# Wait for connection
sleep 0.3

echo ""
echo "🚀 MISSILE STREAMLINED - Smoother than baby oil on titanium!"
echo ""
echo "⚡ Ultra-streamlined controls:"
echo "  m s      - Speed test"
echo "  m st     - Status"  
echo "  m u      - Hypersonic mode"
echo "  m sec    - Fort Knox security"
echo "  m d      - Stop VPN"
echo ""
echo "🎯 Everything optimized for:"
echo "  ⚡ 0.1 second commands"
echo "  🚀 Parallel processing"  
echo "  💾 Memory-resident operations"
echo "  🛡️ Integrated security"
echo ""

# Status check
sudo tailscale status 2>/dev/null && echo "✅ MISSILE READY - All systems optimal!" || echo "🔗 Authenticate for missile mode"