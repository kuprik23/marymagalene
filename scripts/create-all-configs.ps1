# Mary Platform - Complete Configuration Generator
# Creates ALL remaining configuration files efficiently

Write-Host "Creating all configuration files..." -ForegroundColor Green
$baseDir = "C:\Martin\WEB\Mary"
Set-Location $baseDir

# ========================================
# Payment Service (Rust)
# ========================================
@'
[package]
name = "mary-payment"
version = "1.0.0"
edition = "2021"

[dependencies]
actix-web = "4.4"
tokio = { version = "1", features = ["full"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
sqlx = { version = "0.7", features = ["runtime-tokio-native-tls", "postgres"] }
reqwest = { version = "0.11", features = ["json"] }
uuid = { version = "1.6", features = ["v4", "serde"] }
chrono = { version = "0.4", features = ["serde"] }
env_logger = "0.11"
dotenv = "0.15"

[profile.release]
opt-level = 3
lto = true
'@ | Out-File -FilePath "services/payment/Cargo.toml" -Encoding UTF8

# ========================================
# Java Services - build.gradle files
# ========================================

# CRM Service
@'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}
group = 'com.mary'
version = '1.0.0'
sourceCompatibility = '17'
repositories { mavenCentral() }
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-security'
    implementation 'org.springframework.boot:spring-boot-starter-validation'
    implementation 'org.postgresql:postgresql'
    implementation 'org.flywaydb:flyway-core'
    implementation 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
'@ | Out-File -FilePath "services/crm/build.gradle" -Encoding UTF8

# AI Orchestrator
@'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}
group = 'com.mary'
version = '1.0.0'
sourceCompatibility = '17'
repositories { mavenCentral() }
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-webflux'
    implementation 'org.postgresql:postgresql'
    implementation 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
'@ | Out-File -FilePath "services/ai-orchestrator/build.gradle" -Encoding UTF8

# Analytics Service
@'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}
group = 'com.mary'
version = '1.0.0'
sourceCompatibility = '17'
repositories { mavenCentral() }
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-mongodb'
    implementation 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
'@ | Out-File -FilePath "services/analytics/build.gradle" -Encoding UTF8

# ========================================
# Kotlin Service - Integration Hub
# ========================================
@'
plugins {
    kotlin("jvm") version "1.9.21"
    id("io.ktor.plugin") version "2.3.7"
    kotlin("plugin.serialization") version "1.9.21"
}
group = "com.mary"
version = "1.0.0"
repositories { mavenCentral() }
dependencies {
    implementation("io.ktor:ktor-server-core-jvm")
    implementation("io.ktor:ktor-server-netty-jvm")
    implementation("io.ktor:ktor-server-content-negotiation-jvm")
    implementation("io.ktor:ktor-serialization-kotlinx-json-jvm")
    implementation("io.ktor:ktor-client-core")
    implementation("org.postgresql:postgresql:42.7.1")
    testImplementation("io.ktor:ktor-server-tests-jvm")
}
'@ | Out-File -FilePath "services/integration-hub/build.gradle.kts" -Encoding UTF8

# ========================================
# Node.js Services
# ========================================

# MCP Server
@'
{
  "name": "mary-mcp-server",
  "version": "1.0.0",
  "type": "module",
  "main": "dist/index.js",
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js"
  },
  "dependencies": {
    "@modelcontextprotocol/sdk": "^0.5.0",
    "express": "^4.18.2",
    "zod": "^3.22.4",
    "redis": "^4.6.12",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "@types/node": "^20.10.6",
    "typescript": "^5.3.3",
    "tsx": "^4.7.0"
  }
}
'@ | Out-File -FilePath "services/mcp-server/package.json" -Encoding UTF8

@'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true
  }
}
'@ | Out-File -FilePath "services/mcp-server/tsconfig.json" -Encoding UTF8

# WebSocket Server
@'
{
  "name": "mary-websocket-service",
  "version": "1.0.0",
  "type": "module",
  "main": "dist/index.js",
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js"
  },
  "dependencies": {
    "ws": "^8.16.0",
    "express": "^4.18.2",
    "redis": "^4.6.12",
    "jsonwebtoken": "^9.0.2",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "@types/node": "^20.10.6",
    "@types/ws": "^8.5.10",
    "typescript": "^5.3.3",
    "tsx": "^4.7.0"
  }
}
'@ | Out-File -FilePath "services/websocket/package.json" -Encoding UTF8

@'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true
  }
}
'@ | Out-File -FilePath "services/websocket/tsconfig.json" -Encoding UTF8

# ========================================
# Native C++ Modules
# ========================================
@'
cmake_minimum_required(VERSION 3.15)
project(MaryNativeModules)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(filesystem)
add_subdirectory(image-processor)
add_subdirectory(video-transcoder)
add_subdirectory(crypto-accelerator)
'@ | Out-File -FilePath "native/CMakeLists.txt" -Encoding UTF8

# Individual module CMakeLists
$modules = @('filesystem', 'image-processor', 'video-transcoder', 'crypto-accelerator')
foreach ($mod in $modules) {
    @"
cmake_minimum_required(VERSION 3.15)
project($mod)
set(CMAKE_CXX_STANDARD 17)
file(GLOB SOURCES src/*.cpp)
add_library($mod SHARED `${SOURCES})
"@ | Out-File -FilePath "native/$mod/CMakeLists.txt" -Encoding UTF8
}

# ========================================
# Shared Libraries
# ========================================
@'
{
  "name": "@mary/types",
  "version": "1.0.0",
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "scripts": {
    "build": "tsc"
  },
  "devDependencies": {
    "typescript": "^5.3.3"
  }
}
'@ | Out-File -FilePath "shared/types/package.json" -Encoding UTF8

# ========================================
# Documentation Files
# ========================================
@'
# API Documentation

API documentation for Mary Platform services.

## Services

- Gateway: Port 8080
- Auth: Port 8081
- CRM: Port 8082
- AI: Port 8083
- Integration: Port 8084
- Payment: Port 8085
- MCP: Port 8086
- Analytics: Port 8087
- WebSocket: Port 8088
'@ | Out-File -FilePath "docs/api/README.md" -Encoding UTF8

@'
# User Guides

End-user documentation for Mary Platform.
'@ | Out-File -FilePath "docs/user-guides/README.md" -Encoding UTF8

@'
# Developer Documentation

Development guides and best practices.
'@ | Out-File -FilePath "docs/developer/README.md" -Encoding UTF8

# ========================================
# GitHub Workflows
# ========================================
@'
name: Desktop Build
on: [push, pull_request]
jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm install
      - run: npm run build
'@ | Out-File -FilePath ".github/workflows/desktop-build.yml" -Encoding UTF8

@'
name: Backend Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: cargo test --all
'@ | Out-File -FilePath ".github/workflows/backend-tests.yml" -Encoding UTF8

# ========================================
# Development Scripts
# ========================================
@'
#!/bin/bash
echo "Building all services..."
cd services
for dir in */; do
  echo "Building $dir..."
  cd $dir
  if [ -f "Cargo.toml" ]; then
    cargo build --release
  elif [ -f "build.gradle" ]; then
    ./gradlew build
  elif [ -f "package.json" ]; then
    npm run build
  fi
  cd ..
done
'@ | Out-File -FilePath "scripts/build-all.sh" -Encoding UTF8

@'
#!/bin/bash
echo "Running all tests..."
npm test
'@ | Out-File -FilePath "scripts/test-all.sh" -Encoding UTF8

Write-Host "All configuration files created successfully!" -ForegroundColor Green
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  - 9 Backend services configured" -ForegroundColor White
Write-Host "  - 4 Native C++ modules" -ForegroundColor White
Write-Host "  - Desktop app (Tauri + React)" -ForegroundColor White
Write-Host "  - Shared libraries" -ForegroundColor White
Write-Host "  - Infrastructure configs" -ForegroundColor White
Write-Host "  - Documentation structure" -ForegroundColor White
Write-Host "  - CI/CD workflows" -ForegroundColor White