# Mary Platform

> Multi-technology desktop application platform with AI orchestration, CRM, and seamless integrations

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/mary-platform/mary)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/mary-platform/mary/actions)

## 🚀 Overview

Mary is a comprehensive desktop platform that combines:
- 🤖 **AI Agent Orchestration** - Manage multiple AI providers (OpenAI, Anthropic, Google, etc.)
- 👥 **CRM System** - Full-featured customer relationship management
- 🔗 **Universal API Integration** - Connect to any API or service
- 📱 **Social Media Management** - Unified social media posting and analytics
- 💳 **Payment Processing** - Subscription and payment management
- 🖥️ **Desktop App Integration** - Control and interact with local applications
- 🔒 **Enterprise Security** - Bank-grade encryption and security features

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Quick Start](#-quick-start)
- [Technology Stack](#-technology-stack)
- [Project Structure](#-project-structure)
- [Development](#-development)
- [Testing](#-testing)
- [Deployment](#-deployment)
- [Documentation](#-documentation)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### AI & Automation
- Multi-provider AI agent orchestration
- Custom agent creation and management
- Conversation history and context management
- Embeddings and vector search
- Prompt templates and optimization

### CRM & Business Management
- Contact and company management
- Deal pipeline and opportunity tracking
- Activity timeline and history
- Custom fields and tags
- Email integration

### Integration Hub
- Universal API connector
- OAuth2/OIDC authentication
- Webhook management
- Social media platforms (Twitter, LinkedIn, Facebook, Instagram)
- Pre-built integrations

### Client Portal
- White-label client interface
- Project collaboration
- Document sharing
- Invoice management
- Real-time messaging

### Payment & Subscriptions
- Stripe and PayPal integration
- Subscription management
- Invoice generation
- Payment method management
- Usage-based billing

## 🏗️ Architecture

Mary follows a **microservices architecture** with a **monorepo structure**:

```
├── Desktop App (Tauri + React + TypeScript)
├── Backend Services (Rust, Java, Kotlin, TypeScript)
│   ├── API Gateway (Rust/Actix)
│   ├── Auth Service (Rust/Actix)
│   ├── CRM Service (Java/Spring Boot)
│   ├── AI Orchestrator (Java/Spring Boot)
│   ├── Integration Hub (Kotlin/Ktor)
│   ├── Payment Service (Rust/Actix)
│   ├── MCP Server (TypeScript/Node.js)
│   ├── Analytics Service (Java/Spring Boot)
│   └── WebSocket Service (TypeScript/Node.js)
├── Native Modules (C++)
└── Infrastructure (Docker, Kubernetes, Terraform)
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed architecture documentation.

## 🚀 Quick Start

### Prerequisites

- **Node.js** >= 18.0.0
- **Rust** >= 1.70.0
- **Java** >= 17 (for Spring Boot services)
- **Kotlin** >= 1.9.0
- **C++ Compiler** (MSVC, GCC, or Clang)
- **Docker** and **Docker Compose**
- **PostgreSQL** >= 14
- **Redis** >= 7
- **MongoDB** >= 7

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mary-platform/mary.git
   cd mary
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Install dependencies**
   ```bash
   npm install
   ```

4. **Start infrastructure services**
   ```bash
   docker-compose up -d
   ```

5. **Run database migrations**
   ```bash
   npm run migrate
   ```

6. **Start the development environment**
   ```bash
   npm run dev
   ```

7. **Access the application**
   - Desktop App: Launches automatically
   - API Gateway: http://localhost:8080
   - Grafana: http://localhost:3001 (admin/admin)

## 🛠️ Technology Stack

### Frontend
- **Tauri** - Desktop application framework
- **React** - UI library
- **TypeScript** - Type-safe JavaScript
- **Vite** - Build tool
- **Zustand** - State management
- **TailwindCSS** - Styling
- **React Query** - Data fetching

### Backend Services
- **Rust** (Gateway, Auth, Payment) - High-performance systems programming
- **Java/Spring Boot** (CRM, AI, Analytics) - Enterprise-grade services
- **Kotlin/Ktor** (Integration Hub) - Modern JVM microservices
- **TypeScript/Node.js** (MCP, WebSocket) - Real-time and protocol services

### Native Modules (C++)
- Filesystem operations
- Image processing
- Video transcoding
- Cryptographic acceleration

### Databases
- **PostgreSQL** - Primary relational database
- **MongoDB** - Document store
- **Redis** - Cache and sessions

### Infrastructure
- **Docker** - Containerization
- **Kubernetes** - Orchestration
- **Terraform** - Infrastructure as Code
- **Prometheus & Grafana** - Monitoring
- **ELK Stack** - Logging

## 📁 Project Structure

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for detailed project organization.

```
C:\Martin\WEB\Mary\
├── desktop/              # Tauri desktop application
├── services/            # Backend microservices
├── native/              # C++ native modules
├── shared/              # Shared libraries and types
├── infrastructure/      # DevOps configurations
├── docs/                # Documentation
├── scripts/             # Build and deployment scripts
└── tests/               # End-to-end tests
```

## 💻 Development

### Available Commands

```bash
# Development
npm run dev              # Start all services in dev mode
npm run dev:desktop      # Start desktop app only
npm run dev:services     # Start backend services only

# Building
npm run build            # Build all services
npm run build:desktop    # Build desktop app
npm run build:services   # Build backend services

# Testing
npm run test             # Run all tests
npm run test:unit        # Run unit tests
npm run test:integration # Run integration tests
npm run test:e2e         # Run end-to-end tests

# Code Quality
npm run lint             # Lint code
npm run format           # Format code with Prettier
npm run type-check       # TypeScript type checking

# Database
npm run migrate          # Run database migrations
npm run seed             # Seed database with test data

# Utilities
npm run clean            # Clean build artifacts
npm run setup            # Setup development environment
```

### Code Style

- **TypeScript/JavaScript**: ESLint + Prettier
- **Rust**: rustfmt + clippy
- **Java**: Spotless + Checkstyle
- **Kotlin**: ktlint
- **C++**: clang-format

## 🧪 Testing

### Test Structure

```
tests/
├── unit/           # Unit tests (co-located with source)
├── integration/    # Integration tests
├── e2e/            # End-to-end tests
├── performance/    # Load and stress tests
└── security/       # Security tests
```

### Running Tests

```bash
# All tests
npm test

# Specific test suites
npm run test:unit
npm run test:integration
npm run test:e2e

# With coverage
npm run test:coverage

# Watch mode
npm run test:watch
```

## 🚢 Deployment

### Development
```bash
npm run deploy:dev
```

### Staging
```bash
npm run deploy:staging
```

### Production
```bash
npm run deploy:prod
```

See [docs/developer/deployment.md](docs/developer/deployment.md) for detailed deployment instructions.

## 📚 Documentation

- [Architecture](ARCHITECTURE.md) - System architecture and design decisions
- [Project Structure](PROJECT_STRUCTURE.md) - Detailed folder organization
- [Security Plan](SECURITY_PLAN.md) - Security requirements and implementation
- [API Documentation](docs/api/) - API specifications and examples
- [User Guides](docs/user-guides/) - End-user documentation
- [Developer Guides](docs/developer/) - Development documentation

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](docs/developer/contributing.md) for guidelines.

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Tauri](https://tauri.app/)
- Powered by [React](https://react.dev/)
- Backend services with [Actix](https://actix.rs/), [Spring Boot](https://spring.io/projects/spring-boot), and [Ktor](https://ktor.io/)
- AI integrations with OpenAI, Anthropic, and Google

## 📞 Support

- Documentation: [docs/](docs/)
- Issues: [GitHub Issues](https://github.com/mary-platform/mary/issues)
- Discussions: [GitHub Discussions](https://github.com/mary-platform/mary/discussions)

---

**Built with ❤️ by the Mary Platform Team**