#!/bin/sh
#
# Create offline installer bundle
# Usage: ./offline-bundle.sh

set -e

VERSION="2.1.0"
BUNDLE_DIR="project-forge-offline-bundle"
SCRIPT_URL="https://raw.githubusercontent.com/edunoluwadarasimidavid/Project-Bootstrapper/main"

mkdir -p "$BUNDLE_DIR/updates" "$BUNDLE_DIR/signatures"

echo "Downloading components..."

# Download bootstrapper
curl -sL "$SCRIPT_URL/project-forge" -o "$BUNDLE_DIR/project-forge"

# Download logic
curl -sL "$SCRIPT_URL/updates/project-forge.v$VERSION" -o "$BUNDLE_DIR/updates/project-forge.v$VERSION"
curl -sL "$SCRIPT_URL/updates/project-forge.v$VERSION.sha256" -o "$BUNDLE_DIR/updates/project-forge.v$VERSION.sha256"
curl -sL "$SCRIPT_URL/updates/project-forge.v$VERSION.sig" -o "$BUNDLE_DIR/updates/project-forge.v$VERSION.sig"

# Download signatures
curl -sL "$SCRIPT_URL/signatures/public.key" -o "$BUNDLE_DIR/signatures/public.key"

# Download version
curl -sL "$SCRIPT_URL/VERSION" -o "$BUNDLE_DIR/VERSION"

chmod +x "$BUNDLE_DIR/project-forge"

echo "Creating installer..."
cat > "$BUNDLE_DIR/install.sh" <<'EOF'
#!/bin/sh
# Offline installer
INSTALL_DIR="${1:-/usr/local/bin}"
sudo cp project-forge "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/project-forge"
echo "Installed to $INSTALL_DIR"
EOF

chmod +x "$BUNDLE_DIR/install.sh"

# Create tar archive
tar -czf "project-forge-offline-$VERSION.tar.gz" -C "$BUNDLE_DIR" .

echo "Bundle created: project-forge-offline-$VERSION.tar.gz"
echo "To install: tar -xzf project-forge-offline-$VERSION.tar.gz && cd project-forge-offline-bundle && ./install.sh"
