# QuantMesh Docker Setup Script for Windows PowerShell
# This script sets up QuantMesh using Docker images

Write-Host "Setting up QuantMesh Docker..." -ForegroundColor Green

# Load platform detection
. "$PSScriptRoot\detect-platform.ps1"

# Detect platform and get appropriate docker-compose file
$platform = Get-Platform
$composeFile = Get-DockerComposeFile

Write-Host "Detected platform: $platform" -ForegroundColor Cyan
Write-Host "Using compose file: $composeFile" -ForegroundColor Cyan

# Check if Docker is installed
$dockerPath = $null
try {
    # First try if docker is in PATH
    $dockerVersion = docker --version 2>$null
    if ($dockerVersion) {
        Write-Host "Docker is installed: $dockerVersion" -ForegroundColor Green
        $dockerPath = "docker"
    } else {
        throw "Docker not in PATH"
    }
} catch {
    # Try common Docker Desktop installation paths
    $dockerPaths = @(
        "C:\Program Files\Docker\Docker\resources\bin\docker.exe",
        "C:\Program Files (x86)\Docker\Docker\resources\bin\docker.exe",
        "C:\Users\$env:USERNAME\AppData\Local\Docker\Docker\resources\bin\docker.exe",
        "C:\ProgramData\Docker\Docker\resources\bin\docker.exe"
    )
    
    Write-Host "Docker not found in PATH, checking common installation locations..." -ForegroundColor Yellow
    
    foreach ($path in $dockerPaths) {
        if (Test-Path $path) {
            try {
                $dockerVersion = & $path --version 2>$null
                if ($dockerVersion) {
                    $dockerPath = $path
                    Write-Host "Docker is installed: $dockerVersion" -ForegroundColor Green
                    Write-Host "Found at: $path" -ForegroundColor Cyan
                    break
                }
            } catch {}
        }
    }
    
    if (-not $dockerPath) {
        Write-Host "Docker is not installed or not found in common locations." -ForegroundColor Red
        Write-Host ""
        Write-Host "Please install Docker Desktop:" -ForegroundColor Yellow
        Write-Host "1. Download from: https://www.docker.com/products/docker-desktop/" -ForegroundColor White
        Write-Host "2. Install Docker Desktop" -ForegroundColor White
        Write-Host "3. Start Docker Desktop" -ForegroundColor White
        Write-Host "4. Add Docker to PATH (optional but recommended):" -ForegroundColor White
        Write-Host "   - Open Docker Desktop Settings" -ForegroundColor White
        Write-Host "   - Go to General tab" -ForegroundColor White
        Write-Host "   - Check 'Use Docker Compose V2'" -ForegroundColor White
        Write-Host "   - Restart your terminal" -ForegroundColor White
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Check if Docker Compose is installed
try {
    if ($dockerPath) {
        $composeVersion = & $dockerPath compose version 2>$null
    } else {
        $composeVersion = docker compose version 2>$null
    }
    
    if (-not $composeVersion) {
        if ($dockerPath) {
            $composePath = $dockerPath -replace "docker.exe", "docker-compose.exe"
            if (Test-Path $composePath) {
                $composeVersion = & $composePath --version 2>$null
            }
        } else {
            $composeVersion = docker-compose --version 2>$null
        }
        
        if (-not $composeVersion) {
            throw "Docker Compose not found"
        }
    }
    Write-Host "Docker Compose is installed: $composeVersion" -ForegroundColor Green
} catch {
    Write-Host "Docker Compose is not installed. Please install Docker Compose first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if Docker daemon is running
Write-Host "Checking Docker daemon status..." -ForegroundColor Yellow
try {
    if ($dockerPath) {
        & $dockerPath info 2>$null | Out-Null
    } else {
        docker info 2>$null | Out-Null
    }
    if ($LASTEXITCODE -ne 0) {
        throw "Docker daemon not running"
    }
    Write-Host "Docker daemon is running!" -ForegroundColor Green
} catch {
    Write-Host "Docker daemon is not running!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please start Docker Desktop:" -ForegroundColor Yellow
    Write-Host "   - Open Docker Desktop from Start Menu" -ForegroundColor White
    Write-Host "   - Or run: 'C:\Program Files\Docker\Docker\Docker Desktop.exe'" -ForegroundColor White
    Write-Host "   - Wait for Docker Desktop to fully start (30-90 seconds)" -ForegroundColor White
    Write-Host ""
    Write-Host "Waiting for Docker Desktop to start..." -ForegroundColor Yellow
    Write-Host "   (This may take 30-90 seconds on first startup)" -ForegroundColor White
    
    # Wait for Docker to start (max 90 seconds)
    for ($i = 1; $i -le 18; $i++) {
        try {
            if ($dockerPath) {
                & $dockerPath info 2>$null | Out-Null
            } else {
                docker info 2>$null | Out-Null
            }
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Docker Desktop is now running!" -ForegroundColor Green
                break
            }
        } catch {}
        
        Write-Host "   Attempt $i/18: Still waiting for Docker Desktop..." -ForegroundColor Yellow
        Start-Sleep -Seconds 5
    }
    
    # Final check
    try {
        if ($dockerPath) {
            & $dockerPath info 2>$null | Out-Null
        } else {
            docker info 2>$null | Out-Null
        }
        if ($LASTEXITCODE -ne 0) {
            throw "Docker still not running"
        }
    } catch {
        Write-Host "Docker Desktop failed to start after 90 seconds." -ForegroundColor Red
        Write-Host "Please manually start Docker Desktop and run this script again." -ForegroundColor Yellow
        Write-Host "   - Windows: Start Docker Desktop from Start Menu" -ForegroundColor White
        Write-Host "   - Or run: 'C:\Program Files\Docker\Docker\Docker Desktop.exe'" -ForegroundColor White
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Create .env file if it doesn't exist
if (-not (Test-Path ".env")) {
    Write-Host "Creating .env file from template..." -ForegroundColor Yellow
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
        Write-Host "Created .env file. Please edit it with your configuration." -ForegroundColor Green
        Write-Host "IMPORTANT: Update the passwords and secrets in .env before running!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please edit the .env file with your settings:" -ForegroundColor Yellow
        Write-Host "   - POSTGRES_PASSWORD: Set a secure password for PostgreSQL" -ForegroundColor White
        Write-Host "   - REDIS_PASSWORD: Set a secure password for Redis" -ForegroundColor White
        Write-Host "   - SECRET_KEY: Set a 32+ character secret key" -ForegroundColor White
        Write-Host "   - KITE_API_KEY and KITE_API_SECRET: Optional, for Zerodha integration" -ForegroundColor White
        Write-Host ""
        Write-Host "After editing .env, run this script again to start the services." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 0
    } else {
        Write-Host ".env.example file not found!" -ForegroundColor Red
        Write-Host "Please ensure you're running this script from the quantmesh-docker directory." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Configure Docker credentials to avoid credential helper issues
Write-Host "Configuring Docker credentials..." -ForegroundColor Yellow
try {
    # Set environment variable to disable credential helper
    $env:DOCKER_CONFIG = "$env:USERPROFILE\.docker"
    if (-not (Test-Path $env:DOCKER_CONFIG)) {
        New-Item -ItemType Directory -Path $env:DOCKER_CONFIG -Force | Out-Null
    }
    
    # Create or update Docker config to disable credential helper
    $dockerConfigPath = "$env:DOCKER_CONFIG\config.json"
    $dockerConfig = @{
        "credsStore" = ""
        "credHelpers" = @{}
    } | ConvertTo-Json -Depth 3
    
    Set-Content -Path $dockerConfigPath -Value $dockerConfig -Force
    Write-Host "Disabled Docker credential helper" -ForegroundColor Green
} catch {
    Write-Host "Could not configure Docker credentials, continuing..." -ForegroundColor Yellow
}

# Pull the latest images
Write-Host "Pulling latest Docker images..." -ForegroundColor Yellow
try {
    if ($dockerPath -ne "docker") {
        & $dockerPath compose -f $composeFile pull
    } else {
        docker compose -f $composeFile pull
    }
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to pull images"
    }
} catch {
    Write-Host "Failed to pull Docker images. This might be due to:" -ForegroundColor Red
    Write-Host "1. Internet connection issues" -ForegroundColor Yellow
    Write-Host "2. Docker credentials not configured" -ForegroundColor Yellow
    Write-Host "3. Docker Hub rate limiting" -ForegroundColor Yellow
    Write-Host "4. Platform architecture mismatch (ARM64 vs AMD64)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Trying to continue with existing images..." -ForegroundColor Cyan
    Write-Host "If images are not available locally, you may need to:" -ForegroundColor Yellow
    Write-Host "- Check your internet connection" -ForegroundColor White
    Write-Host "- Login to Docker Hub: docker login" -ForegroundColor White
    Write-Host "- Or try again later" -ForegroundColor White
    Write-Host ""
}

# Start the services
Write-Host "Starting QuantMesh services..." -ForegroundColor Yellow
$servicesStarted = $false

try {
    if ($dockerPath -ne "docker") {
        & $dockerPath compose -f $composeFile up -d
    } else {
        docker compose -f $composeFile up -d
    }
    if ($LASTEXITCODE -eq 0) {
        $servicesStarted = $true
    } else {
        throw "Platform-specific compose file failed"
    }
} catch {
    Write-Host "Platform-specific configuration failed. Trying default configuration..." -ForegroundColor Yellow
    Write-Host "This is normal if the images were built for a different architecture." -ForegroundColor Cyan
    Write-Host ""
    
    try {
        if ($dockerPath -ne "docker") {
            & $dockerPath compose up -d
        } else {
            docker compose up -d
        }
        if ($LASTEXITCODE -eq 0) {
            $servicesStarted = $true
            Write-Host "Successfully started services using default configuration!" -ForegroundColor Green
        } else {
            throw "Default configuration also failed"
        }
    } catch {
        Write-Host "Both platform-specific and default configurations failed." -ForegroundColor Red
        Write-Host ""
        Write-Host "This usually means:" -ForegroundColor Yellow
        Write-Host "1. Docker images are not available for your platform" -ForegroundColor White
        Write-Host "2. Images were built for a different architecture (ARM64 vs AMD64)" -ForegroundColor White
        Write-Host "3. Network connectivity issues" -ForegroundColor White
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "1. Check if Docker images exist: docker images | grep quantmesh" -ForegroundColor Cyan
        Write-Host "2. Try building images locally for your platform" -ForegroundColor Cyan
        Write-Host "3. Check Docker Hub for available images" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Please check the logs for more details:" -ForegroundColor Yellow
        Write-Host "   docker compose logs" -ForegroundColor White
        Read-Host "Press Enter to exit"
        exit 1
    }
}

if (-not $servicesStarted) {
    Write-Host "Failed to start services with any configuration." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "QuantMesh is starting up!" -ForegroundColor Green
Write-Host "Access the application at: http://localhost" -ForegroundColor Cyan
Write-Host "Backend API: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Health check: http://localhost/health" -ForegroundColor Cyan
Write-Host ""
Write-Host "Useful commands:" -ForegroundColor Yellow
Write-Host "  docker compose logs -f          # View logs" -ForegroundColor White
Write-Host "  docker compose ps               # Check status" -ForegroundColor White
Write-Host "  docker compose down             # Stop services" -ForegroundColor White
Write-Host "  docker compose restart          # Restart services" -ForegroundColor White
Write-Host ""
Write-Host "Setup complete! Your QuantMesh instance is now running." -ForegroundColor Green
Read-Host "Press Enter to exit"