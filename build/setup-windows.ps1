# QuantMesh Docker Setup for Windows PowerShell
# This is a convenience script that runs the main setup script

Write-Host "QuantMesh Docker Setup for Windows" -ForegroundColor Green
Write-Host ""

# Check if we're in the right directory
if (-not (Test-Path "docker-compose.yml")) {
    Write-Host "Error: docker-compose.yml not found!" -ForegroundColor Red
    Write-Host "Please run this script from the quantmesh-docker directory." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Current directory: $PWD" -ForegroundColor White
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if scripts directory exists
if (-not (Test-Path "scripts\setup.ps1")) {
    Write-Host "Error: setup.ps1 not found in scripts directory!" -ForegroundColor Red
    Write-Host "Please ensure you have the complete quantmesh-docker repository." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Found quantmesh-docker directory" -ForegroundColor Green
Write-Host "Starting setup..." -ForegroundColor Yellow
Write-Host ""

# Run the main setup script
& ".\scripts\setup.ps1"

Write-Host ""
Write-Host "Setup process completed!" -ForegroundColor Green
Read-Host "Press Enter to exit"
