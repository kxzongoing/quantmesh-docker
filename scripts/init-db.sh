#!/bin/bash

# QuantMesh Database Initialization Script
# This script initializes the database with required tables and data

set -e

echo "🗄️  Initializing QuantMesh database..."

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
until docker compose exec postgres pg_isready -U ${POSTGRES_USER:-quantmesh_user} -d ${POSTGRES_DB:-quantmesh}; do
    echo "PostgreSQL is unavailable - sleeping"
    sleep 2
done

echo "✅ PostgreSQL is ready!"

# Run database migrations (if any)
echo "🔄 Running database migrations..."
# Note: Add your migration commands here when available

echo "✅ Database initialization complete!"
echo "🌐 You can now access QuantMesh at http://localhost"
