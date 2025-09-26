#!/bin/bash

# QuantMesh Docker Setup Script
# This script sets up QuantMesh using Docker images

set -e

echo "🚀 Setting up QuantMesh Docker..."

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
    echo "🔧 Please start Docker Desktop:"
    echo "   • macOS/Windows: Open Docker Desktop application"
    echo "   • Linux: sudo systemctl start docker"
    echo ""
    echo "⏳ Waiting for Docker to start..."
    echo "   (This may take 30-60 seconds on first startup)"
    
    # Wait for Docker to start (max 60 seconds)
    for i in {1..12}; do
        if docker info &> /dev/null; then
            echo "✅ Docker daemon is now running!"
            break
        fi
        echo "   Attempt $i/12: Still waiting for Docker..."
        sleep 5
    done
    
    # Final check
    if ! docker info &> /dev/null; then
        echo "❌ Docker daemon failed to start after 60 seconds."
        echo "🔧 Please manually start Docker Desktop and run this script again."
        exit 1
    fi
else
    echo "✅ Docker daemon is running!"
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env file. Please edit it with your configuration."
    echo "⚠️  IMPORTANT: Update the passwords and secrets in .env before running!"
    exit 0
fi

# Pull the latest images
echo "📥 Pulling latest Docker images..."
docker compose pull

# Start the services
echo "🚀 Starting QuantMesh services..."
docker compose up -d

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
