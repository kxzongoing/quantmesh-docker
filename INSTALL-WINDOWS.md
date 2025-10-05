# Windows Installation Guide for QuantMesh Docker

This guide will help you install and run QuantMesh Docker on Windows.

## Prerequisites

### 1. Install Docker Desktop for Windows

**Download and Install Docker Desktop:**
1. Go to [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/)
2. Download the installer
3. Run the installer as Administrator
4. Follow the installation wizard
5. Restart your computer if prompted

**Verify Installation:**
```cmd
docker --version
docker compose version
```

**Optional: Add Docker to PATH**
If Docker commands are not recognized, you can add Docker to your PATH:

1. Open Docker Desktop Settings
2. Go to General tab
3. Check "Use Docker Compose V2"
4. Restart your terminal/command prompt

Alternatively, the setup scripts will automatically find Docker even if it's not in PATH.

### 2. System Requirements
- Windows 10 64-bit: Pro, Enterprise, or Education (Build 15063 or later)
- Windows 11 64-bit: Home or Pro
- WSL 2 feature enabled
- Virtualization enabled in BIOS
- 4GB RAM minimum
- 10GB free disk space

## Quick Setup

### Option 1: Using Command Prompt (Recommended)
```cmd
# Clone the repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Run the setup script
setup-windows.bat
```

### Option 2: Using PowerShell
```powershell
# Clone the repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Run the PowerShell setup script
.\setup-windows.ps1
```

## Manual Setup

If the automated scripts don't work, you can set up manually:

### 1. Create Environment File
```cmd
copy .env.example .env
```

### 2. Edit the .env file
Open `.env` in a text editor and update these values:
```
POSTGRES_PASSWORD=your_secure_password_here
REDIS_PASSWORD=your_secure_password_here
SECRET_KEY=your_32_character_secret_key_here
```

### 3. Start the Services
```cmd
docker compose up -d
```

### 4. Access the Application
- Main Application: http://localhost
- API: http://localhost:8000
- Health Check: http://localhost/health

## Troubleshooting

### Docker Not Found
If you get "docker is not recognized", Docker Desktop is not installed or not in PATH:
1. Install Docker Desktop from the official website
2. Restart your computer
3. Open a new Command Prompt or PowerShell window
4. Try `docker --version` again

### Docker Desktop Not Starting
1. Make sure virtualization is enabled in BIOS
2. Enable WSL 2 feature: `wsl --install`
3. Restart your computer
4. Start Docker Desktop from Start Menu

### Port Already in Use
If port 80 or 5432 is already in use:
1. Stop other services using these ports
2. Or modify the ports in `docker-compose.yml`

### Permission Issues
Run Command Prompt or PowerShell as Administrator if you encounter permission errors.

### Docker Credentials Issues
If you see "docker-credential-desktop" errors:

```cmd
# Login to Docker Hub (optional)
docker login

# Or disable credential helper
docker config --global credential.helper ""

# Or use Docker Desktop settings
# Go to Docker Desktop > Settings > General > Uncheck "Use Docker Compose V2"
```

### Docker Not Found in PATH
The setup scripts automatically find Docker even if it's not in PATH. If you want to add Docker to PATH:

1. Open Docker Desktop
2. Go to Settings > General
3. Check "Use Docker Compose V2"
4. Restart your terminal

### Platform Architecture Issues
If you see "platform (linux/arm64) does not match the detected host platform (linux/amd64)" warnings:

**This is normal and expected!** The setup scripts automatically use `docker-compose.windows.yml` which forces AMD64 architecture for Windows compatibility.

**Solutions:**
1. **Automatic**: The setup scripts handle this automatically
2. **Manual**: Use `docker-compose.windows.yml` instead of `docker-compose.yml`
3. **Multi-platform**: Rebuild images with `docker buildx build --platform linux/amd64,linux/arm64`

## Useful Commands

```cmd
# View logs
docker compose -f docker-compose.windows.yml logs -f

# Check status
docker compose -f docker-compose.windows.yml ps

# Stop services
docker compose -f docker-compose.windows.yml down

# Restart services
docker compose -f docker-compose.windows.yml restart

# Update to latest images
docker compose -f docker-compose.windows.yml pull
docker compose -f docker-compose.windows.yml up -d
```

## Getting Help

If you encounter issues:
1. Check the logs: `docker compose logs`
2. Verify Docker is running: `docker info`
3. Check the [GitHub Issues](https://github.com/kxzongoing/quantmesh-docker/issues)
4. Contact support: [founder@quantmesh.in](mailto:founder@quantmesh.in)
