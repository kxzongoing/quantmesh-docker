#!/bin/bash
# Multi-Platform Docker Build Script for QuantMesh
# This script builds and pushes multi-platform images to Docker Hub

set -e

echo "🚀 Building Multi-Platform Docker Images for QuantMesh"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Check if logged into Docker Hub
if ! docker info | grep -q "Username:"; then
    echo "🔐 Please login to Docker Hub first:"
    echo "   docker login"
    echo ""
    read -p "Press Enter after logging in..."
fi

# Create a new builder instance for multi-platform builds
echo "🔧 Setting up multi-platform builder..."
docker buildx create --name multiplatform --use --bootstrap

# Define platforms
PLATFORMS="linux/amd64,linux/arm64"

echo "📦 Building and pushing multi-platform images..."
echo "Platforms: $PLATFORMS"
echo ""

# Build and push backend image
echo "🏗️  Building kxzongoing/quantmesh-backend:latest..."
docker buildx build \
    --platform $PLATFORMS \
    --tag kxzongoing/quantmesh-backend:latest \
    --tag kxzongoing/quantmesh-backend:$(date +%Y%m%d) \
    --push \
    ./backend

echo "✅ Backend image pushed successfully!"
echo ""

# Build and push frontend image
echo "🏗️  Building kxzongoing/quantmesh-frontend:latest..."
docker buildx build \
    --platform $PLATFORMS \
    --tag kxzongoing/quantmesh-frontend:latest \
    --tag kxzongoing/quantmesh-frontend:$(date +%Y%m%d) \
    --push \
    ./frontend

echo "✅ Frontend image pushed successfully!"
echo ""

# Build and push nginx image
echo "🏗️  Building kxzongoing/quantmesh-nginx:latest..."
docker buildx build \
    --platform $PLATFORMS \
    --tag kxzongoing/quantmesh-nginx:latest \
    --tag kxzongoing/quantmesh-nginx:$(date +%Y%m%d) \
    --push \
    ./nginx

echo "✅ Nginx image pushed successfully!"
echo ""

echo "🎉 All multi-platform images have been built and pushed to Docker Hub!"
echo ""
echo "📋 Image Summary:"
echo "   - kxzongoing/quantmesh-backend:latest (AMD64 + ARM64)"
echo "   - kxzongoing/quantmesh-frontend:latest (AMD64 + ARM64)"
echo "   - kxzongoing/quantmesh-nginx:latest (AMD64 + ARM64)"
echo ""
echo "🌍 These images will now work on:"
echo "   - Windows AMD64"
echo "   - macOS Intel"
echo "   - macOS M1/M2 (ARM64)"
echo "   - Linux AMD64"
echo "   - Linux ARM64"
echo ""
echo "✅ Users can now run the setup scripts on any platform!"
