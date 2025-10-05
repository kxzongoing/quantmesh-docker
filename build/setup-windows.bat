@echo off
REM QuantMesh Docker Setup for Windows
REM This is a convenience script that runs the main setup script

echo QuantMesh Docker Setup for Windows
echo.

REM Check if we're in the right directory
if not exist "docker-compose.yml" (
    echo Error: docker-compose.yml not found!
    echo Please run this script from the quantmesh-docker directory.
    echo.
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)

REM Check if scripts directory exists
if not exist "scripts\setup.bat" (
    echo Error: setup.bat not found in scripts directory!
    echo Please ensure you have the complete quantmesh-docker repository.
    echo.
    pause
    exit /b 1
)

echo Found quantmesh-docker directory
echo Starting setup...
echo.

REM Run the main setup script
call scripts\setup.bat

echo.
echo Setup process completed!
pause
