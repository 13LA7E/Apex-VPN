FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Install Tailscale during build for instant startup
RUN curl -fsSL https://tailscale.com/install.sh | sh && \
    mkdir -p /var/lib/tailscale /var/run/tailscale && \
    chmod 755 /var/lib/tailscale /var/run/tailscale

# Pre-configure for instant startup  
USER vscode