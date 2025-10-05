# 🚀 Building Multi-Platform Docker Images

## Overview

Since the original images were built on Mac M1 (ARM64), they only work on ARM64 platforms. To make QuantMesh work on **all platforms**, you need to build and push **multi-platform images** to Docker Hub.

## 🎯 What This Achieves

- ✅ **Windows AMD64**: Images will work on Windows
- ✅ **macOS Intel**: Images will work on Intel Macs
- ✅ **macOS M1/M2**: Images will work on ARM64 Macs
- ✅ **Linux AMD64**: Images will work on standard Linux
- ✅ **Linux ARM64**: Images will work on ARM-based Linux

## 🚀 Quick Start

### **Option 1: Automated Scripts (Recommended)**

#### For macOS/Linux:
```bash
# Make script executable
chmod +x build-multiplatform.sh

# Run the build script
./build-multiplatform.sh
```

#### For Windows:
```powershell
# Run the PowerShell build script
.\build-multiplatform.ps1
```

### **Option 2: Manual Commands**

#### 1. Set up Docker Buildx
```bash
# Create a new builder instance
docker buildx create --name multiplatform --use --bootstrap

# Verify the builder
docker buildx ls
```

#### 2. Login to Docker Hub
```bash
docker login
```

#### 3. Build and Push Multi-Platform Images

**Backend:**
```bash
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag kxzongoing/quantmesh-backend:latest \
    --push \
    ./backend
```

**Frontend:**
```bash
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag kxzongoing/quantmesh-frontend:latest \
    --push \
    ./frontend
```

**Nginx:**
```bash
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag kxzongoing/quantmesh-nginx:latest \
    --push \
    ./nginx
```

## 🔍 Verification

After building, verify the images are multi-platform:

```bash
# Check image manifests
docker buildx imagetools inspect kxzongoing/quantmesh-backend:latest
docker buildx imagetools inspect kxzongoing/quantmesh-frontend:latest
docker buildx imagetools inspect kxzongoing/quantmesh-nginx:latest
```

You should see both `linux/amd64` and `linux/arm64` platforms listed.

## 🧪 Testing

### **Test on Windows:**
```cmd
# Clone the repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Run the setup script
.\scripts\setup.ps1
```

### **Test on macOS:**
```bash
# Clone the repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Run the setup script
./scripts/setup.sh
```

### **Test on Linux:**
```bash
# Clone the repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Run the setup script
./scripts/setup.sh
```

## 📋 Prerequisites

- **Docker Desktop** with Buildx support
- **Docker Hub account** and login
- **Repository structure** with `backend/`, `frontend/`, and `nginx/` directories
- **Dockerfiles** in each directory

## 🛠️ Troubleshooting

### **Buildx Not Available**
```bash
# Update Docker Desktop to latest version
# Or install buildx plugin manually
docker buildx version
```

### **Authentication Issues**
```bash
# Login to Docker Hub
docker login

# Check authentication
docker info | grep Username
```

### **Platform Not Supported**
```bash
# Check available platforms
docker buildx ls

# Create new builder with specific platforms
docker buildx create --name multiplatform --driver docker-container --use
```

## 🎯 Expected Results

After successful build and push:

1. **Docker Hub** will show multi-platform images
2. **Setup scripts** will work on all platforms
3. **No more platform mismatch errors**
4. **Universal compatibility** across all systems

## 📊 Build Time

- **First build**: 10-15 minutes (downloads base images)
- **Subsequent builds**: 5-10 minutes (uses cache)
- **Push time**: 2-5 minutes (depends on internet speed)

## 🔄 CI/CD Integration

For automated builds, add this to your GitHub Actions:

```yaml
name: Build Multi-Platform Images

on:
  push:
    tags: ['v*']

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: docker/setup-buildx-action@v2
      
      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      
      - name: Build and push
        run: |
          docker buildx build --platform linux/amd64,linux/arm64 --tag kxzongoing/quantmesh-backend:latest --push ./backend
          docker buildx build --platform linux/amd64,linux/arm64 --tag kxzongoing/quantmesh-frontend:latest --push ./frontend
          docker buildx build --platform linux/amd64,linux/arm64 --tag kxzongoing/quantmesh-nginx:latest --push ./nginx
```

## ✅ Success Checklist

- [ ] Docker Buildx is installed and working
- [ ] Logged into Docker Hub
- [ ] Multi-platform images built and pushed
- [ ] Images verified with `docker buildx imagetools inspect`
- [ ] Setup scripts tested on Windows
- [ ] Setup scripts tested on macOS
- [ ] Setup scripts tested on Linux
- [ ] No platform mismatch errors
- [ ] All services start successfully

## 🎉 Result

Once completed, **any user on any platform** can run:

```bash
# Windows
.\scripts\setup.ps1

# macOS/Linux
./scripts/setup.sh
```

And it will work perfectly! 🚀
