# 🐳 QuantMesh Docker

**Ready-to-run QuantMesh using Docker images**

QuantMesh is a quantitative portfolio analytics platform that connects to your Zerodha holdings and provides advanced performance metrics, risk analysis, and behavioral insights.

## 📋 Table of Contents

| Section                                               | Description                             |
| ----------------------------------------------------- | --------------------------------------- |
| [🔹 What it is](#-what-it-is-)                        | Platform overview and purpose           |
| [🧠 What It Does](#-what-it-does)                     | Core functionality and features         |
| [💡 Why It Matters](#-why-it-matters)                 | Value proposition and mission           |
| [🚀 Platform Features](#-quantmesh-platform-features) | Detailed feature breakdown              |
| [⚠️ Caveats & Disclaimers](#️-caveats--disclaimers)   | Important limitations                   |
| [🚀 Quick Start](#-quick-start)                       | Installation and setup guide            |
| [🌐 Access Points](#-access-points)                   | Application URLs and endpoints          |
| [📊 Services](#-services)                             | Service architecture and ports          |
| [⚙️ Configuration](#️-configuration)                  | Environment setup and API configuration |
| [🛠️ Management Commands](#️-management-commands)      | Docker management and operations        |
| [🔧 Troubleshooting](#-troubleshooting)               | Common issues and solutions             |
| [⚠️ Important Usage Notes](#️-important-usage-notes)  | Critical app usage guidelines           |
| [🔒 Security](#-security)                             | Security best practices                 |
| [📈 Features](#-features)                             | Key platform capabilities               |
| [🆘 Support](#-support)                               | Documentation and help resources        |
| [📄 License](#-license)                               | Licensing information and terms         |

---

## 🔹 What it is 🔹

QuantMesh connects directly to your holdings with Zerodha and processes portfolio data to surface quant-style insights — covering performance, risk, and insightful behavioural metrics.

The platform is focused on analytical depth, automation, and intuitive dashboards.

## 🧠 What It Does

- 📊 Connects to Zerodha accounts via Kite MCP
- ⚙️ Computes advanced portfolio performance & risk metrics
- 📉 Displays visual analytics like CAGR, Sharpe Ratio, drawdowns, volatility, Beta & more
- 🧾 Generates ready-to-use reports for research and review
- 🧠 Future roadmap includes technical signals, sentiment overlays, and AI/LLM integrations for insights

## 💡 Why It Matters

- Retail traders have more tools than ever — what’s hard is turning raw portfolio data into actionable, quant-grade insight.
- The challenge isn’t access, it’s synthesis: bringing performance, risk, and behaviour into one coherent view.
- Great platforms exist; what’s scant and growing is a portfolio-first quant analytics layer for retail traders/investors that explains the ‘why,’ not just the ‘what.’
- India’s trading stack is strong; QuantMesh makes an effort to complement it by translating holdings data into decision-ready insights.
- In an age where AI and Tools are abundant, what’s missing is clarity; understanding is scarce. QuantMesh focuses on teaching traders to read their own data - statistically.
- Better outcomes start with better awareness—linking holdings to risk, behaviour, and long-run performance.
- The next leap isn’t more charts—it’s context. QuantMesh adds the ‘so what’ to your portfolio data.
- QuantMesh is designed to extend the mission of empowering the retail investor — by adding a layer of quantitative portfolio analytics for better risk awareness and decision-making.

## 🚀 **QuantMesh Platform Features**

> **Aims to be a professional-grade portfolio management and analytics platform offering advanced quantitative analysis.**

---

### **📊 Core Dashboard** (`/dashboard`)

- **Portfolio Overview**: Real-time portfolio valuation and P&L tracking
- **Asset Allocation**: Visual breakdown of equity holdings
- **Live Market Data**: 10-second polling during market hours
- **Performance Indicators**: Color-coded profit/loss indicators

### **💼 Portfolio Management**

- **Stocks** (`/holdings`): Real-time holdings table with live market data and performance metrics
- **Trading** (`/orders`, `/trades`): Complete order tracking and trade history
- **Market Data** (`/quotes`): Real-time market quotes and instrument search

---

### **🔬 Advanced Analytics & Quantitative Analysis**

#### **📊 Portfolio Analytics** (`/analytics`)

**Professional-Grade Portfolio Analysis with Advanced Metrics**

**Core Performance Metrics:**

- **Annualized Returns**: Multi-timeframe analysis (1Y, 3Y, 5Y) with compound annual growth rate
- **Risk-Adjusted Returns**: Sharpe ratio, Sortino ratio, and Calmar ratio calculations
- **Volatility Analysis**: Annualized volatility, rolling volatility, and volatility clustering
- **Drawdown Analysis**: Maximum drawdown, average drawdown, and recovery time analysis

---

### **🔬 Advanced Analytics & Quantitative Analysis**

#### **📊 Portfolio Analytics** (`/analytics`)

**Professional-Grade Portfolio Analysis**

- **Comprehensive Portfolio Metrics**: Multi-dimensional performance analysis with risk assessment
- **Risk Analysis**: Volatility, Sharpe ratio, and risk-adjusted returns calculation
- **Performance Attribution**: Sector and asset class performance breakdown
- **Multi-timeframe Analysis**: 1Y, 3Y, 5Y performance comparisons with benchmark analysis
- **Advanced Visualizations**: Interactive charts, graphs, and quantitative analysis tools
- **Portfolio Optimization**: Efficient frontier analysis and optimization algorithms

#### **📈 Per-Stock Metrics** (`/per-stock-metrics`)

**Individual Stock Deep Analysis**

- **Individual Stock Analysis**: Detailed metrics for each holding with multi-timeframe performance
- **Risk Metrics**: Volatility and risk-adjusted returns per stock with factor analysis
- **Performance Comparison**: Stock vs portfolio performance with advanced analytics
- **Visualization Tools**: Interactive charts and performance graphs with quantitative tools

#### **📊 Benchmark Metrics** (`/benchmark-metrics`)

**Market Benchmark Intelligence**

- **Market Benchmark Analysis**: NIFTY 50, BANKNIFTY performance tracking
- **Multi-timeframe Benchmarking**: 1Y, 3Y, 5Y benchmark analysis with relative performance
- **Market Analysis**: Sector and index performance insights with real-time integration
- **Benchmark Integration**: Live market data integration for comprehensive analysis

---

### **🔧 System & Monitoring Features**

#### **📊 System Monitoring** (`/monitoring`)

**Platform Health & Performance**

- **System Status**: Real-time platform health monitoring with service availability
- **API Performance**: Request/response time tracking with error monitoring
- **Performance Metrics**: Platform performance indicators and health checks
- **Error Monitoring**: System error tracking with comprehensive alerts

#### **👤 Profile Management** (`/profile`)

**User & Authentication Management**

- **User Profile**: Account information and settings management
- **Authentication Management**: Login/logout functionality with session management
- **Settings Configuration**: User preferences and platform configurations

---

### **🔧 System Features**

- **Monitoring** (`/monitoring`): System health and API performance tracking
- **Profile** (`/profile`): User authentication and settings management
- **Real-time Data**: Live market polling with intelligent caching and rate limiting

---

## ⚠️ Caveats & Disclaimers

QuantMesh isn’t an advisory tool — it’s a grassroots initiative for the retail traders, built to spark quantitative awareness, learning, and better decisions through data. Not tips or recommendations, but simply a vertical dive into their own portfolio.

- For educational purposes only.
- This is a pure analytics tool. It does not provide trading or investment advice.
- Born out of weekend tinkering and curiosity, QuantMesh is a bootstrapped MVP built by a systems & quant developer — not a trader/advisor. The creator is not a SEBI-registered RA/RI or financial advisor.

---

## 🚀 Quick Start

### Prerequisites

- **Docker** (20.10+) - [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **Docker Compose** (2.0+)
- **4GB RAM** minimum
- **10GB free disk space**

> **⚠️ Important**: Make sure Docker Desktop is running before proceeding. If you see "Cannot connect to the Docker daemon" errors, start Docker Desktop first.

### One-Command Setup - Execute these only once when you set QuantMesh for the first time.

```bash
# Clone this repository
git clone https://github.com/kxzongoing/quantmesh-docker.git
cd quantmesh-docker

# Verify Docker is running (optional but recommended)
docker --version

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

   **Or; manual setup for configuring environment - if required**

   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

2. Run the setup script again:

   ```bash
   ./scripts/setup.sh
   ```

   **This will automatically pull images and start the docker containers. But if not, use Step 3 below.**

3. **Start Services**

   ```bash
   docker compose up -d
   ```

### 🌐 Access Points

- **Main Application**: http://localhost
- **API Endpoint**: http://localhost/api
- **Health Check**: http://localhost/health
- **Database**: localhost:5432 (quantmesh_user/your_password)
- **Redis**: localhost:6379 (password: your_redis_password)

## 📊 Services

### Port Configurations and Service Descriptions

| Service        | Port           | Docker Image (Information Only)        | Description                           |
| -------------- | -------------- | -------------------------------------- | ------------------------------------- |
| **Backend**    | 80             | `kxzongoing/quantmesh-backend:latest`  | FastAPI + FastMCP Backend application |
| **Frontend**   | 8000           | `kxzongoing/quantmesh-frontend:latest` | React Frontend application            |
| **Nginx**      | 80 (via Nginx) | `kxzongoing/quantmesh-nginx:latest`    | Reverse proxy and static file serving |
| **PostgreSQL** | 5432           | `postgres:15-alpine`                   | Database                              |
| **Redis**      | 6379           | `redis:7-alpine`                       | Cache and session storage             |

## ⚙️ Configuration

### Environment Variables

Edit `.env` file with your settings:

```bash
# Database
POSTGRES_PASSWORD=your_secure_password

# Application
SECRET_KEY=your_secret_key_32_chars_minimum
```

### [OPTIONAL] Kite Connect Setup (The platform runs on Kite MCP and hence this is not a requirement.)

1. Visit [Kite Connect](https://kite.trade/)
2. Create a developer account
3. Generate API key and secret
4. Update `KITE_API_KEY` and `KITE_API_SECRET` in `.env`
5. Set redirect URL to `http://localhost/api/kite/callback`

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

## 🔧 Troubleshooting

### Common Issues

**Docker daemon not running:**

```bash
# Error: "Cannot connect to the Docker daemon at unix:///Users/username/.docker/run/docker.sock"
# Solution: Start Docker Desktop
# - macOS/Windows: Open Docker Desktop application
# - Linux: sudo systemctl start docker
# - Verify: docker --version
```

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

## ⚠️ Important Usage Notes

> **🚨 Critical App Usage Guidelines**

- **🔄 Holdings Not Refreshing?** If holdings aren't updating, **DO NOT** leave the app. Simply click the **green Login button** (top right) to reactivate the MCP session and refresh the page.

- **📊 Market Data Polling** Markets quotes are set for persistent polling every **10 seconds** during market hours. Use the **"Expand Metrics"** button to view detailed timeframe performance and risk metrics.

- **📈 Returns Calculation** Behind the scenes, all calculations use **Annualized Mean Returns** and **Annualized Volatility** unless specifically stated as Avg Returns/Total Returns.

## 🔒 Security

- Keep Docker images updated
- Change default passwords in `.env`. Any required sensitive data must be logged in environment variables (.env file)
- API keys / Credentials are not exposed in the frontend nor logged by the backend
- Rate limiting is implemented for API endpoints
- Database and Redis are password protected. Use strong `SECRET_KEY` (32+ characters)

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
- **Email**: [founder@quantmesh.in](mailto:founder@quantmesh.in)

## 📄 License

This project is licensed under the Business Source License (BSL) 1.1 - see the [LICENSE](LICENSE) file for details.

🔹 Key Features of this License

- **Free** for non-commercial, educational & research purposes.
- **Commercial users** must get a license from QuantMesh Technologies.
- **Redistribution allowed** only with attribution & no rebranding.
- **Automatic conversion** to AGPL.
- **Protects QuantMesh trademark & Name, IP and other elements.**

---

**⚠️ Disclaimer**: QuantMesh is for educational and analytical purposes only. It does not provide investment advice. Always do your own research before making investment decisions.

---
