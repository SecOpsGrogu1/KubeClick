# KubeClick

KubeClick is an open-source CLI tool designed to simplify and speed up your Kubernetes workflow. It provides intuitive shortcuts and commands that make working with Kubernetes clusters more efficient.

## Features

- Simple, intuitive commands that replace lengthy kubectl commands
- Smart autocompletion for all commands
- Cross-platform support (Linux, macOS, Windows)
- No need for manual alias setup
- Context-aware operations
- Built-in resource management shortcuts

## Installation

### macOS
```bash
brew install kubeclick
```

### Linux (Ubuntu/Debian)
```bash
curl -s https://raw.githubusercontent.com/kubeclick/kubeclick/main/install.sh | sudo bash
```

### Windows
```powershell
choco install kubeclick
```

## Quick Start

```bash
# List all pods
kc pods

# Get logs from a pod
kc logs pod-name

# Execute into a pod
kc exec pod-name

# Switch namespace
kc ns namespace-name

# Get all resources in current namespace
kc all
```

## Command Reference

| Command | Description | Equivalent kubectl |
|---------|-------------|-------------------|
| `kc pods` | List all pods | `kubectl get pods` |
| `kc svc` | List all services | `kubectl get svc` |
| `kc dep` | List deployments | `kubectl get deployments` |
| `kc ctx` | Switch context | `kubectl config use-context` |
| `kc ns` | Switch namespace | `kubectl config set-context --current --namespace` |

## Development

Requirements:
- Go 1.21 or higher
- Make

```bash
# Clone the repository
git clone https://github.com/kubeclick/kubeclick.git

# Build
make build

# Run tests
make test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE for more details
