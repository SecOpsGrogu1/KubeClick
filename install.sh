#!/bin/bash

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64)
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
VERSION="0.1.0"  # This should be updated for each release
BINARY_NAME="kc"
DOWNLOAD_URL="https://github.com/SecOpsGrogu1/KubeClick/releases/download/v${VERSION}/${BINARY_NAME}-${OS}-${ARCH}"

# Download binary
echo "Downloading KubeClick..."
curl -L -o "/tmp/${BINARY_NAME}" "${DOWNLOAD_URL}"

# Make binary executable
chmod +x "/tmp/${BINARY_NAME}"

# Move binary to /usr/local/bin
echo "Installing KubeClick..."
sudo mv "/tmp/${BINARY_NAME}" "/usr/local/bin/${BINARY_NAME}"

# Verify installation
if command -v ${BINARY_NAME} >/dev/null; then
    echo "KubeClick has been installed successfully!"
    echo "Run 'kc --help' to get started"
else
    echo "Installation failed. Please try again or install manually."
    exit 1
fi
