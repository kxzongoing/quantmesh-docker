#!/bin/bash
# Platform Detection Script for QuantMesh Docker
# This script detects the platform and returns the appropriate docker-compose file

detect_platform() {
    local os=$(uname -s)
    local arch=$(uname -m)
    
    case "$os" in
        "Darwin")
            # macOS
            if [[ "$arch" == "arm64" ]]; then
                echo "macos-arm64"
            else
                echo "macos-amd64"
            fi
            ;;
        "Linux")
            # Linux
            if [[ "$arch" == "aarch64" || "$arch" == "arm64" ]]; then
                echo "linux-arm64"
            else
                echo "linux-amd64"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

get_docker_compose_file() {
    local platform=$(detect_platform)
    
    case "$platform" in
        "macos-arm64")
            echo "docker-compose.macos.yml"
            ;;
        "macos-amd64")
            echo "docker-compose.macos-intel.yml"
            ;;
        "linux-arm64")
            echo "docker-compose.linux-arm.yml"
            ;;
        "linux-amd64")
            echo "docker-compose.linux.yml"
            ;;
        *)
            echo "docker-compose.yml"
            ;;
    esac
}

# Export functions
export -f detect_platform get_docker_compose_file
