# India VPN ⚡ 

**Instant** Tailscale VPN for GitHub Codespaces - connects in **0.3 seconds**!

## ✨ Features
- **⚡ Ultra-fast startup** - VPN ready in 0.3 seconds
- **🔄 Auto-connects** - Starts instantly when codespace opens
- **🇮🇳 India IP** - Access geo-restricted content
- **🛠️ Simple controls** - Easy management commands

## 🚀 Quick Start

1. **Fork this repo**
2. **Open in Codespaces**  
3. **Wait 0.3 seconds** - VPN is ready!

The VPN connects automatically and instantly when your codespace starts.

## ⚡ Ultra-Fast Commands

```bash
# Instant startup (0.3 seconds!)
./ultra-fast.sh

# Full control
./vpn status    # Check status
./vpn up        # Start VPN  
./vpn down      # Stop VPN
./vpn restart   # Restart VPN
```

## 🎯 How It's So Fast

- **Pre-installed Tailscale** in container build
- **Background startup** - no blocking waits  
- **Parallel connections** - daemon + connect simultaneously
- **Minimal output** - no unnecessary status checks

## 🔧 Setup Your Own

1. Create a [Tailscale account](https://tailscale.com)
2. Set up exit nodes in your preferred locations
3. Fork this repo and enjoy instant VPN!

## 📍 Exit Node Locations

Configure exit nodes anywhere:
- India 🇮🇳 - Bypass geo-restrictions
- USA 🇺🇸 - Access US content  
- Europe �� - GDPR-compliant browsing
- Any location with your devices

---

*Blazingly fast VPN for developers. From codespace start to VPN ready in 0.3 seconds.* ⚡

🇮🇳 **Tailscale VPN Setup for Codespaces**

This repository provides automated Tailscale setup for GitHub Codespaces, allowing you to access your India-based resources securely.

## 🚀 Quick Start

### Method 1: Manual Start (Immediate)
```bash
./start-tailscale.sh
```

### Method 2: Auto-start with Terminal
Add to your `~/.bashrc`:
```bash
echo "source /workspaces/India-VPN/tailscale-bashrc-addition.sh" >> ~/.bashrc
```

### Method 3: Service-like Management
```bash
chmod +x tailscale-service.sh
./tailscale-service.sh start    # Start daemon
./tailscale-service.sh status   # Check status
./tailscale-service.sh stop     # Stop daemon
```

## 📁 Files Included

- **`start-tailscale.sh`** - Main startup script
- **`setup-tailscale-codespace.sh`** - Initial setup (installs Tailscale if needed)
- **`tailscale-service.sh`** - Service management script
- **`tailscale-bashrc-addition.sh`** - Bash profile addition
- **`.devcontainer/devcontainer.json`** - Auto-setup for new codespaces

## 🔧 Auto-Start Options

### Option 1: Using .devcontainer (Recommended)
The `.devcontainer/devcontainer.json` will automatically:
- Install Tailscale on container creation
- Start Tailscale daemon when codespace starts

### Option 2: Manual Bashrc Addition
```bash
# Add this line to ~/.bashrc for auto-start on terminal open
/workspaces/India-VPN/start-tailscale.sh
```

### Option 3: GitHub Codespaces dotfiles
Add the startup command to your dotfiles repository.

## 🛠️ Troubleshooting

### If Tailscale isn't installed:
```bash
./setup-tailscale-codespace.sh
```

### Check daemon status:
```bash
./tailscale-service.sh status
```

### Manual connection:
```bash
sudo tailscale up
```

### View logs:
```bash
tail -f /tmp/tailscale-daemon.log
```

## 🌐 Usage

Once connected, you'll have access to your Tailscale network including any India-based resources, exit nodes, or subnet routes configured in your Tailnet.

Check your connection:
```bash
sudo tailscale status
```

## 📝 Notes

- First connection requires authentication via the Tailscale web interface
- Container warnings (DNS, TPM) are normal and don't affect functionality
- The daemon runs in the background and survives terminal closures
- Use `tailscale down` to disconnect when done