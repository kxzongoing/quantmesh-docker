# Multi-Platform Docker Build Script for QuantMesh (Windows PowerShell)
# This script builds and pushes multi-platform images to Docker Hub

Write-Host "🚀 Building Multi-Platform Docker Images for QuantMesh" -ForegroundColor Green
Write-Host ""

# Check if Docker is running
try {
    docker info | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Docker not running"
    }
} catch {
    Write-Host "❌ Docker is not running. Please start Docker Desktop first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if logged into Docker Hub
$dockerInfo = docker info 2>$null
if (-not ($dockerInfo -match "Username:")) {
    Write-Host "🔐 Please login to Docker Hub first:" -ForegroundColor Yellow
    Write-Host "   docker login" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Press Enter after logging in"
}

# Create a new builder instance for multi-platform builds
Write-Host "🔧 Setting up multi-platform builder..." -ForegroundColor Yellow
docker buildx create --name multiplatform --use --bootstrap

# Define platforms
$PLATFORMS = "linux/amd64,linux/arm64"

Write-Host "📦 Building and pushing multi-platform images..." -ForegroundColor Yellow
Write-Host "Platforms: $PLATFORMS" -ForegroundColor Cyan
Write-Host ""

# Build and push backend image
Write-Host "🏗️  Building kxzongoing/quantmesh-backend:latest..." -ForegroundColor Yellow
docker buildx build --platform $PLATFORMS --tag kxzongoing/quantmesh-backend:latest --tag kxzongoing/quantmesh-backend:$(Get-Date -Format "yyyyMMdd") --push ./backend

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Backend image pushed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to build backend image" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Build and push frontend image
Write-Host "🏗️  Building kxzongoing/quantmesh-frontend:latest..." -ForegroundColor Yellow
docker buildx build --platform $PLATFORMS --tag kxzongoing/quantmesh-frontend:latest --tag kxzongoing/quantmesh-frontend:$(Get-Date -Format "yyyyMMdd") --push ./frontend

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Frontend image pushed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to build frontend image" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Build and push nginx image
Write-Host "🏗️  Building kxzongoing/quantmesh-nginx:latest..." -ForegroundColor Yellow
docker buildx build --platform $PLATFORMS --tag kxzongoing/quantmesh-nginx:latest --tag kxzongoing/quantmesh-nginx:$(Get-Date -Format "yyyyMMdd") --push ./nginx

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Nginx image pushed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to build nginx image" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

Write-Host "🎉 All multi-platform images have been built and pushed to Docker Hub!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Image Summary:" -ForegroundColor Cyan
Write-Host "   - kxzongoing/quantmesh-backend:latest (AMD64 + ARM64)" -ForegroundColor White
Write-Host "   - kxzongoing/quantmesh-frontend:latest (AMD64 + ARM64)" -ForegroundColor White
Write-Host "   - kxzongoing/quantmesh-nginx:latest (AMD64 + ARM64)" -ForegroundColor White
Write-Host ""
Write-Host "🌍 These images will now work on:" -ForegroundColor Cyan
Write-Host "   - Windows AMD64" -ForegroundColor White
Write-Host "   - macOS Intel" -ForegroundColor White
Write-Host "   - macOS M1/M2 (ARM64)" -ForegroundColor White
Write-Host "   - Linux AMD64" -ForegroundColor White
Write-Host "   - Linux ARM64" -ForegroundColor White
Write-Host ""
Write-Host "✅ Users can now run the setup scripts on any platform!" -ForegroundColor Green
Read-Host "Press Enter to exit"
