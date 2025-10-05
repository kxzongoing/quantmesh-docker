# 🌍 Cross-Platform Support for QuantMesh Docker

## Overview

QuantMesh Docker now supports **automatic platform detection** and uses the appropriate Docker configuration for your system. This ensures compatibility across all major platforms and architectures.

## 🎯 Supported Platforms

| Platform | Architecture | Compose File | Platform Detection |
|----------|-------------|--------------|-------------------|
| **Windows** | AMD64 | `docker-compose.windows.yml` | ✅ Automatic |
| **Windows** | ARM64 | `docker-compose.windows-arm.yml` | ✅ Automatic |
| **macOS** | ARM64 (M1/M2) | `docker-compose.macos.yml` | ✅ Automatic |
| **macOS** | Intel | `docker-compose.macos-intel.yml` | ✅ Automatic |
| **Linux** | AMD64 | `docker-compose.linux.yml` | ✅ Automatic |
| **Linux** | ARM64 | `docker-compose.linux-arm.yml` | ✅ Automatic |

## 🔧 How It Works

### 1. **Platform Detection Scripts**
- **Windows**: `scripts/detect-platform.ps1` (PowerShell)
- **Linux/macOS**: `scripts/detect-platform.sh` (Bash)

### 2. **Automatic Compose File Selection**
The setup scripts automatically:
1. Detect your operating system and architecture
2. Select the appropriate `docker-compose.*.yml` file
3. Use platform-specific Docker configurations
4. Handle architecture mismatches gracefully

### 3. **Platform-Specific Configurations**

#### Windows AMD64
```yaml
services:
  backend:
    image: kxzongoing/quantmesh-backend:latest
    platform: linux/amd64  # Forces AMD64 architecture
```

#### macOS ARM64 (M1/M2)
```yaml
services:
  backend:
    image: kxzongoing/quantmesh-backend:latest
    platform: linux/arm64  # Native ARM64 support
```

#### Linux AMD64
```yaml
services:
  backend:
    image: kxzongoing/quantmesh-backend:latest
    platform: linux/amd64  # Standard Linux
```

## 🚀 Usage

### Automatic Setup (Recommended)
The setup scripts automatically detect your platform:

```bash
# Linux/macOS
./scripts/setup.sh

# Windows
.\scripts\setup.ps1
```

### Manual Platform Selection
If you need to use a specific platform configuration:

```bash
# Use Windows AMD64 configuration
docker compose -f docker-compose.windows.yml up -d

# Use macOS ARM64 configuration  
docker compose -f docker-compose.macos.yml up -d

# Use Linux AMD64 configuration
docker compose -f docker-compose.linux.yml up -d
```

## 🔍 Platform Detection Logic

### Windows Detection
```powershell
# Detects Windows architecture
$os = $env:OS
$arch = $env:PROCESSOR_ARCHITECTURE

if ($os -eq "Windows_NT") {
    if ($arch -eq "ARM64") {
        return "windows-arm64"
    } else {
        return "windows-amd64"
    }
}
```

### Linux/macOS Detection
```bash
# Detects Unix-like systems
os=$(uname -s)
arch=$(uname -m)

case "$os" in
    "Darwin")
        if [[ "$arch" == "arm64" ]]; then
            echo "macos-arm64"
        else
            echo "macos-amd64"
        fi
        ;;
    "Linux")
        if [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
            echo "linux-arm64"
        else
            echo "linux-amd64"
        fi
        ;;
esac
```

## 🛠️ Troubleshooting

### Platform Mismatch Warnings
If you see warnings like:
```
WARNING: The requested image's platform (linux/arm64) does not match the detected host platform (linux/amd64/v4)
```

**This is normal!** The setup scripts handle this automatically by using platform-specific compose files.

### Manual Override
If automatic detection fails, you can manually specify the compose file:

```bash
# Force Windows AMD64
docker compose -f docker-compose.windows.yml up -d

# Force macOS ARM64
docker compose -f docker-compose.macos.yml up -d
```

### Docker Buildx for Multi-Platform Images
For advanced users who want to build multi-platform images:

```bash
# Create a new builder instance
docker buildx create --name multiplatform --use

# Build multi-platform images
docker buildx build --platform linux/amd64,linux/arm64 -t kxzongoing/quantmesh-backend:latest --push .
```

## 📋 Benefits

1. **✅ Universal Compatibility**: Works on any platform without manual configuration
2. **✅ Automatic Detection**: No need to specify platform manually
3. **✅ Architecture Optimization**: Uses the best architecture for your system
4. **✅ Error Prevention**: Prevents platform mismatch errors
5. **✅ Future-Proof**: Easy to add support for new platforms

## 🔄 Migration from Single Platform

If you were previously using a single `docker-compose.yml`:

1. **No changes needed** - The scripts automatically detect your platform
2. **Backward compatible** - Old configurations still work
3. **Enhanced performance** - Platform-specific optimizations

## 📚 Additional Resources

- [Windows Installation Guide](INSTALL-WINDOWS.md)
- [Docker Multi-Platform Builds](https://docs.docker.com/buildx/working-with-buildx/)
- [Docker Compose Platform Specification](https://docs.docker.com/compose/compose-file/compose-file-v3/#platform)
