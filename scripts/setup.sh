#!/bin/bash

# QuantMesh Docker Setup Script
# This script sets up QuantMesh using Docker images

set -e

echo "🚀 Setting up QuantMesh Docker..."

# Load platform detection
source "$(dirname "$0")/detect-platform.sh"

# Detect platform and get appropriate docker-compose file
PLATFORM=$(detect_platform)
COMPOSE_FILE=$(get_docker_compose_file)

echo "🔍 Detected platform: $PLATFORM"
echo "📄 Using compose file: $COMPOSE_FILE"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "📥 Download Docker Desktop: https://www.docker.com/products/docker-desktop/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Check if Docker daemon is running
echo "🔍 Checking Docker daemon status..."
if ! docker info &> /dev/null; then
    echo "❌ Docker daemon is not running!"
    echo ""
    
    # Check if Docker Desktop is installed
    DOCKER_DESKTOP_INSTALLED=false
    DOCKER_DESKTOP_PATH=""
    
    # Detect OS and check for Docker Desktop
    case "$OSTYPE" in
        darwin*)
            # macOS
            if [ -d "/Applications/Docker.app" ]; then
                DOCKER_DESKTOP_INSTALLED=true
                DOCKER_DESKTOP_PATH="/Applications/Docker.app"
                echo "🐳 Docker Desktop found on macOS"
            fi
            ;;
        linux-gnu*)
            # Check if running in WSL (Windows Subsystem for Linux)
            if grep -q Microsoft /proc/version 2>/dev/null; then
                # Windows WSL
                WIN_PATHS=(
                    "/mnt/c/Program Files/Docker/Docker/Docker Desktop.exe"
                    "/mnt/c/Program Files (x86)/Docker/Docker/Docker Desktop.exe"
                    "C:\Program Files\Docker\Docker\Docker Desktop.exe"
                    "C:\Program Files (x86)\Docker\Docker\Docker Desktop.exe"
                )
                
                for path in "${WIN_PATHS[@]}"; do
                    if [ -f "$path" ] || command -v "$path" &> /dev/null; then
                        DOCKER_DESKTOP_INSTALLED=true
                        DOCKER_DESKTOP_PATH="$path"
                        echo "🐳 Docker Desktop found on Windows (WSL)"
                        break
                    fi
                done
            else
                # Native Linux
                LINUX_PATHS=(
                    "docker-desktop"
                    "/usr/local/bin/docker-desktop"
                    "/usr/bin/docker-desktop"
                    "/opt/docker-desktop/bin/docker-desktop"
                )
                
                for path in "${LINUX_PATHS[@]}"; do
                    if command -v "$path" &> /dev/null || [ -f "$path" ]; then
                        DOCKER_DESKTOP_INSTALLED=true
                        DOCKER_DESKTOP_PATH="$path"
                        echo "🐳 Docker Desktop found on Linux"
                        break
                    fi
                done
                
                # Also check for desktop file
                if [ "$DOCKER_DESKTOP_INSTALLED" = false ] && [ -f "/usr/share/applications/docker-desktop.desktop" ]; then
                    DOCKER_DESKTOP_INSTALLED=true
                    DOCKER_DESKTOP_PATH="docker-desktop"
                    echo "🐳 Docker Desktop found on Linux (desktop file)"
                fi
            fi
            ;;
        msys*|cygwin*|win32*)
            # Native Windows (Git Bash, Cygwin, etc.)
            WIN_PATHS=(
                "/c/Program Files/Docker/Docker/Docker Desktop.exe"
                "/c/Program Files (x86)/Docker/Docker/Docker Desktop.exe"
                "C:/Program Files/Docker/Docker/Docker Desktop.exe"
                "C:/Program Files (x86)/Docker/Docker/Docker Desktop.exe"
            )
            
            for path in "${WIN_PATHS[@]}"; do
                if [ -f "$path" ] || command -v "$path" &> /dev/null; then
                    DOCKER_DESKTOP_INSTALLED=true
                    DOCKER_DESKTOP_PATH="$path"
                    echo "🐳 Docker Desktop found on Windows"
                    break
                fi
            done
            ;;
        *)
            echo "⚠️  Unsupported OS type: $OSTYPE"
            ;;
    esac
    
    if [ "$DOCKER_DESKTOP_INSTALLED" = true ]; then
        echo "🚀 Attempting to start Docker Desktop automatically..."
        
        # Start Docker Desktop based on detected path and OS
        case "$OSTYPE" in
            darwin*)
                # macOS: Use open command
                if [ -n "$DOCKER_DESKTOP_PATH" ]; then
                    open "$DOCKER_DESKTOP_PATH"
                else
                    open -a Docker
                fi
                ;;
            linux-gnu*)
                if grep -q Microsoft /proc/version 2>/dev/null; then
                    # Windows WSL: Start Docker Desktop
                    if [ -n "$DOCKER_DESKTOP_PATH" ]; then
                        "$DOCKER_DESKTOP_PATH" &
                    fi
                else
                    # Native Linux: Start Docker Desktop
                    if [ -n "$DOCKER_DESKTOP_PATH" ]; then
                        "$DOCKER_DESKTOP_PATH" &
                    fi
                fi
                ;;
            msys*|cygwin*|win32*)
                # Native Windows: Start Docker Desktop
                if [ -n "$DOCKER_DESKTOP_PATH" ]; then
                    "$DOCKER_DESKTOP_PATH" &
                fi
                ;;
        esac
        
        echo "⏳ Waiting for Docker Desktop to start..."
        echo "   (This may take 30-90 seconds on first startup)"
        
        # Wait for Docker to start (max 90 seconds for Docker Desktop)
        for i in {1..18}; do
            if docker info &> /dev/null; then
                echo "✅ Docker Desktop is now running!"
                break
            fi
            echo "   Attempt $i/18: Still waiting for Docker Desktop..."
            sleep 5
        done
        
        # Final check
        if ! docker info &> /dev/null; then
            echo "❌ Docker Desktop failed to start after 90 seconds."
            echo "🔧 Please manually start Docker Desktop and run this script again."
            case "$OSTYPE" in
                darwin*)
                    echo "   • macOS: Open Docker Desktop from Applications or run 'open -a Docker'"
                    ;;
                linux-gnu*)
                    if grep -q Microsoft /proc/version 2>/dev/null; then
                        echo "   • Windows WSL: Start Docker Desktop from Windows Start Menu"
                        echo "   • Or run: '/mnt/c/Program Files/Docker/Docker/Docker Desktop.exe'"
                    else
                        echo "   • Linux: Run 'docker-desktop' command or start from applications menu"
                    fi
                    ;;
                msys*|cygwin*|win32*)
                    echo "   • Windows: Start Docker Desktop from Start Menu"
                    echo "   • Or run: 'C:/Program Files/Docker/Docker/Docker Desktop.exe'"
                    ;;
            esac
            exit 1
        fi
    else
        echo "❌ Docker Desktop is not installed!"
        echo ""
        echo "📥 Please install Docker Desktop:"
        case "$OSTYPE" in
            darwin*)
                echo "   • macOS: https://docs.docker.com/desktop/install/mac-install/"
                echo "   • Or: brew install --cask docker"
                ;;
            linux-gnu*)
                if grep -q Microsoft /proc/version 2>/dev/null; then
                    echo "   • Windows WSL: https://docs.docker.com/desktop/install/windows-install/"
                else
                    echo "   • Linux: https://docs.docker.com/desktop/install/linux-install/"
                    echo "   • Or: sudo apt install docker-desktop (Ubuntu/Debian)"
                fi
                ;;
            msys*|cygwin*|win32*)
                echo "   • Windows: https://docs.docker.com/desktop/install/windows-install/"
                ;;
        esac
        echo ""
        echo "🔧 Alternative for Linux: Install Docker Engine:"
        echo "   sudo systemctl start docker"
        exit 1
    fi
else
    echo "✅ Docker daemon is running!"
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "✅ Created .env file. Please edit it with your configuration."
        echo "⚠️  IMPORTANT: Update the passwords and secrets in .env before running!"
        echo ""
        echo "📝 Please edit the .env file with your settings:"
        echo "   • POSTGRES_PASSWORD: Set a secure password for PostgreSQL"
        echo "   • REDIS_PASSWORD: Set a secure password for Redis"
        echo "   • SECRET_KEY: Set a 32+ character secret key"
        echo "   • KITE_API_KEY and KITE_API_SECRET: Optional, for Zerodha integration"
        echo ""
        echo "After editing .env, run this script again to start the services."
        exit 0
    else
        echo "❌ .env.example file not found!"
        echo "Please ensure you're running this script from the quantmesh-docker directory."
        exit 1
    fi
fi

# Pull the latest images
echo "📥 Pulling latest Docker images..."
docker compose -f "$COMPOSE_FILE" pull

# Start the services
echo "🚀 Starting QuantMesh services..."
docker compose -f "$COMPOSE_FILE" up -d

echo "✅ QuantMesh is starting up!"
echo "🌐 Access the application at: http://localhost"
echo "📊 Backend API: http://localhost:8000"
echo "🔍 Health check: http://localhost/health"

echo ""
echo "📋 Useful commands:"
echo "  docker compose logs -f          # View logs"
echo "  docker compose ps               # Check status"
echo "  docker compose down             # Stop services"
echo "  docker compose restart          # Restart services"
