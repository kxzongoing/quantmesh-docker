# Platform Detection Script for QuantMesh Docker
# This script detects the platform and returns the appropriate docker-compose file

function Get-Platform {
    $os = $env:OS
    $arch = $env:PROCESSOR_ARCHITECTURE
    
    # Detect Windows
    if ($os -eq "Windows_NT") {
        # Check if running on ARM64 Windows
        if ($arch -eq "ARM64") {
            return "windows-arm64"
        } else {
            return "windows-amd64"
        }
    }
    
    # Detect macOS
    if ($IsMacOS -or $env:OS -eq "Darwin") {
        # Check if running on Apple Silicon
        $uname = uname -m 2>$null
        if ($uname -eq "arm64") {
            return "macos-arm64"
        } else {
            return "macos-amd64"
        }
    }
    
    # Detect Linux
    if ($IsLinux -or $env:OS -eq "Linux") {
        $uname = uname -m 2>$null
        if ($uname -eq "aarch64" -or $uname -eq "arm64") {
            return "linux-arm64"
        } else {
            return "linux-amd64"
        }
    }
    
    # Default fallback
    return "unknown"
}

function Get-DockerComposeFile {
    $platform = Get-Platform
    
    switch ($platform) {
        "windows-amd64" { return "docker-compose.windows.yml" }
        "windows-arm64" { return "docker-compose.windows-arm.yml" }
        "macos-arm64" { return "docker-compose.macos.yml" }
        "macos-amd64" { return "docker-compose.macos-intel.yml" }
        "linux-amd64" { return "docker-compose.linux.yml" }
        "linux-arm64" { return "docker-compose.linux-arm.yml" }
        default { return "docker-compose.yml" }
    }
}

# Export functions for use in other scripts
# Note: Export-ModuleMember only works in modules, so we'll use dot-sourcing instead
