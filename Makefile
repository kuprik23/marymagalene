# Mary Platform - Development Makefile
# Common commands for building and managing the project

.PHONY: help install dev build test clean docker setup migrate

# Default target
help:
	@echo "Mary Platform - Available Commands:"
	@echo ""
	@echo "  make install       - Install all dependencies"
	@echo "  make dev           - Start development environment"
	@echo "  make build         - Build all services"
	@echo "  make test          - Run all tests"
	@echo "  make clean         - Clean build artifacts"
	@echo "  make docker        - Start Docker services"
	@echo "  make docker-down   - Stop Docker services"
	@echo "  make setup         - Setup development environment"
	@echo "  make migrate       - Run database migrations"
	@echo "  make seed          - Seed database with test data"
	@echo "  make lint          - Run linters"
	@echo "  make format        - Format code"
	@echo ""

# Install dependencies
install:
	@echo "📦 Installing dependencies..."
	npm install
	cd desktop && npm install
	cd services/mcp-server && npm install
	cd services/websocket && npm install
	@echo "✅ Dependencies installed"

# Development
dev:
	@echo "🚀 Starting development environment..."
	npm run dev

dev-desktop:
	@echo "🖥️  Starting desktop app..."
	cd desktop && npm run dev

dev-services:
	@echo "⚙️  Starting backend services..."
	docker-compose up

# Build
build:
	@echo "🔨 Building all services..."
	npm run build

build-desktop:
	@echo "🖥️  Building desktop app..."
	cd desktop && npm run build

build-services:
	@echo "⚙️  Building backend services..."
	sh scripts/build-services.sh

build-native:
	@echo "⚡ Building native modules..."
	sh scripts/build-native.sh

# Testing
test:
	@echo "🧪 Running all tests..."
	npm run test

test-unit:
	@echo "🧪 Running unit tests..."
	npm run test:unit

test-integration:
	@echo "🧪 Running integration tests..."
	npm run test:integration

test-e2e:
	@echo "🧪 Running E2E tests..."
	npm run test:e2e

# Docker
docker:
	@echo "🐳 Starting Docker services..."
	docker-compose up -d

docker-down:
	@echo "🐳 Stopping Docker services..."
	docker-compose down

docker-logs:
	@echo "📋 Showing Docker logs..."
	docker-compose logs -f

docker-rebuild:
	@echo "🐳 Rebuilding Docker services..."
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d

# Database
migrate:
	@echo "🗄️  Running database migrations..."
	sh scripts/migrate-db.sh

seed:
	@echo "🌱 Seeding database..."
	sh scripts/seed-db.sh

# Code Quality
lint:
	@echo "🔍 Running linters..."
	npm run lint

format:
	@echo "💅 Formatting code..."
	npm run format

# Utilities
clean:
	@echo "🧹 Cleaning build artifacts..."
	sh scripts/clean.sh

setup:
	@echo "⚙️  Setting up development environment..."
	sh scripts/setup-dev.sh

# Deployment
deploy-dev:
	@echo "🚀 Deploying to development..."
	sh scripts/deploy.sh dev

deploy-staging:
	@echo "🚀 Deploying to staging..."
	sh scripts/deploy.sh staging

deploy-prod:
	@echo "🚀 Deploying to production..."
	sh scripts/deploy.sh prod

# Monitoring
logs:
	@echo "📋 Tailing logs..."
	docker-compose logs -f

status:
	@echo "📊 Service status..."
	docker-compose ps