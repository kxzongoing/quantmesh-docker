# 🐳 QuantMesh Docker

**Ready-to-run QuantMesh using Docker images - No source code required!**

QuantMesh is a quantitative portfolio analytics platform that connects to your Zerodha holdings and provides advanced performance metrics, risk analysis, and behavioral insights.

## 🚀 Quick Start

### Prerequisites

- **Docker** (20.10+)
- **Docker Compose** (2.0+)
- **4GB RAM** minimum
- **10GB free disk space**

### One-Command Setup - Execute these only once when you set QuantMesh for the first time.

```bash
# Clone this repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Run the setup script
./scripts/setup.sh
```

**First Run Output:**
When you run the setup script for the first time, you'll see:

```
🚀 Setting up QuantMesh Docker...
📝 Creating .env file from template...
✅ Created .env file. Please edit it with your configuration.
⚠️  IMPORTANT: Update the passwords and secrets in .env before running!
```

**Next Steps:**

1. Edit the `.env` file with your configuration (see [Configuration](#️-configuration) section)
2. Run the setup script again:
   ```bash
   ./scripts/setup.sh
   ```

**Manual Setup**

1. **Configure Environment**

   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

2. **Start Services**

   ```bash
   docker compose up -d
   ```

3. **Access Application**
   - **Main App**: http://localhost
   - **API**: http://localhost:8000
   - **Health Check**: http://localhost/health

## ⚙️ Configuration

### Environment Variables

Edit `.env` file with your settings:

```bash
# Database
POSTGRES_PASSWORD=your_secure_password

# Application
SECRET_KEY=your_secret_key_32_chars_minimum

# Optional: Zerodha Integration
KITE_API_KEY=your_kite_api_key
KITE_API_SECRET=your_kite_api_secret
```

### Port Configuration

| Service    | Port | Description      |
| ---------- | ---- | ---------------- |
| Nginx      | 80   | Main application |
| Backend    | 8000 | API server       |
| PostgreSQL | 5433 | Database         |
| Redis      | 6379 | Cache            |

## 🛠️ Management Commands

```bash
# View logs
docker compose logs -f

# Check status
docker compose ps

# Restart services
docker compose restart

# Stop services
docker compose down

# Update to latest images
docker compose pull
docker compose up -d
```

## 📊 Services

| Service        | Image                                  | Description         |
| -------------- | -------------------------------------- | ------------------- |
| **Backend**    | `kxzongoing/quantmesh-backend:latest`  | FastAPI application |
| **Frontend**   | `kxzongoing/quantmesh-frontend:latest` | React dashboard     |
| **Nginx**      | `kxzongoing/quantmesh-nginx:latest`    | Reverse proxy       |
| **PostgreSQL** | `postgres:15-alpine`                   | Database            |
| **Redis**      | `redis:7-alpine`                       | Cache               |

## 🔧 Troubleshooting

### Common Issues

**Port 5432 already in use:**

```bash
# Check what's using the port
lsof -i :5432
or
lsof -i :5433
# Stop conflicting PostgreSQL service
brew services stop postgresql@14  # macOS
```

**Services not starting:**

```bash
# Check logs
docker compose logs

# Restart specific service
docker compose restart backend
```

**Database connection issues:**

```bash
# Check PostgreSQL logs
docker compose logs postgres

# Restart database
docker compose restart postgres
```

### Health Checks

- **Application**: http://localhost/health
- **Backend**: http://localhost:8000/health
- **Database**: `docker compose exec postgres pg_isready`

## 🔒 Security

- Change default passwords in `.env`
- Use strong `SECRET_KEY` (32+ characters)
- Configure `ALLOWED_ORIGINS` for production
- Keep Docker images updated

## 📈 Features

- **Portfolio Analytics**: Advanced performance metrics
- **Risk Analysis**: Sharpe ratio, volatility, drawdowns
- **Real-time Data**: Live market data integration
- **Zerodha Integration**: Direct Kite API connection
- **Professional Reports**: Export-ready analytics

## 🆘 Support

- **Documentation**: [Full Documentation](https://github.com/kxzongoing/quantmesh-docker)
- **Issues**: [GitHub Issues](https://github.com/kxzongoing/quantmesh-docker/issues)
- **Discussions**: [GitHub Discussions](https://github.com/kxzongoing/quantmesh-docker/discussions)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**⚠️ Disclaimer**: QuantMesh is for educational and analytical purposes only. It does not provide investment advice. Always do your own research before making investment decisions.
