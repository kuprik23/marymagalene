# Mary Platform - Service Configuration Generator
# Creates all necessary configuration files for backend services

Write-Host "Creating service configuration files..." -ForegroundColor Green

$baseDir = "C:\Martin\WEB\Mary"
Set-Location $baseDir

# ========================================
# Rust Services (Gateway, Auth, Payment)
# ========================================

# Gateway Service
$gatewayCargoToml = @'
[package]
name = "mary-gateway"
version = "1.0.0"
edition = "2021"

[dependencies]
actix-web = "4.4"
actix-cors = "0.7"
actix-rt = "2.9"
tokio = { version = "1", features = ["full"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
reqwest = { version = "0.11", features = ["json"] }
env_logger = "0.11"
log = "0.4"
dotenv = "0.15"
jsonwebtoken = "9.2"
redis = { version = "0.24", features = ["tokio-comp", "connection-manager"] }
uuid = { version = "1.6", features = ["v4", "serde"] }
chrono = { version = "0.4", features = ["serde"] }

[profile.release]
opt-level = 3
lto = true
codegen-units = 1
'@
$gatewayCargoToml | Out-File -FilePath "services/gateway/Cargo.toml" -Encoding UTF8

# Auth Service
$authCargoToml = @'
[package]
name = "mary-auth"
version = "1.0.0"
edition = "2021"

[dependencies]
actix-web = "4.4"
actix-rt = "2.9"
tokio = { version = "1", features = ["full"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
sqlx = { version = "0.7", features = ["runtime-tokio-native-tls", "postgres"] }
argon2 = "0.5"
jsonwebtoken = "9.2"
redis = { version = "0.24", features = ["tokio-comp", "connection-manager"] }
uuid = { version = "1.6", features = ["v4", "serde"] }
chrono = { version = "0.4", features = ["serde"] }
validator = { version = "0.16", features = ["derive"] }
thiserror = "1.0"
env_logger = "0.11"
dotenv = "0.15"

[profile.release]
opt-level = 3
lto = true
'@
$authCargoToml | Out-File -FilePath "services/auth/Cargo.toml" -Encoding UTF8

# Payment Service
$paymentCargoToml = @'
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
stripe-rust = "0.25"
env_logger = "0.11"
dotenv = "0.15"

[profile.release]
opt-level = 3
lto = true
'@
$paymentCargoToml | Out-File -FilePath "services/payment/Cargo.toml" -Encoding UTF8

# ========================================
# Java Services (CRM, AI, Analytics)
# ========================================

# CRM Service - build.gradle
$crmBuildGradle = @'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.mary'
version = '1.0.0'
sourceCompatibility = '17'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-security'
    implementation 'org.springframework.boot:spring-boot-starter-validation'
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
    implementation 'org.postgresql:postgresql'
    implementation 'org.flywaydb:flyway-core'
    implementation 'io.jsonwebtoken:jjwt-api:0.12.3'
    runtimeOnly 'io.jsonwebtoken:jjwt-impl:0.12.3'
    runtimeOnly 'io.jsonwebtoken:jjwt-jackson:0.12.3'
    implementation 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.springframework.security:spring-security-test'
}

tasks.named('test') {
    useJUnitPlatform()
}
'@
$crmBuildGradle | Out-File -FilePath "services/crm/build.gradle" -Encoding UTF8

# AI Orchestrator - build.gradle
$aiBuildGradle = @'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.mary'
version = '1.0.0'
sourceCompatibility = '17'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-webflux'
    implementation 'org.postgresql:postgresql'
    implementation 'com.theokanning.openai-gpt3-java:service:0.18.2'
    implementation 'dev.langchain4j:langchain4j:0.25.0'
    implementation 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

tasks.named('test') {
    useJUnitPlatform()
}
'@
$aiBuildGradle | Out-File -FilePath "services/ai-orchestrator/build.gradle" -Encoding UTF8

# Analytics Service - build.gradle
$analyticsBuildGradle = @'
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.mary'
version = '1.0.0'
sourceCompatibility = '17'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-mongodb'
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
    implementation 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

tasks.named('test') {
    useJUnitPlatform()
}
'@
$analyticsBuildGradle | Out-File -FilePath "services/analytics/build.gradle" -Encoding UTF8

# ========================================
# Kotlin Service (Integration Hub)
# ========================================

$integrationBuildGradle = @'
plugins {
    kotlin("jvm") version "1.9.21"
    id("io.ktor.plugin") version "2.3.7"
    kotlin("plugin.serialization") version "1.9.21"
}

group = "com.mary"
version = "1.0.0"

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.ktor:ktor-server-core-jvm")
    implementation("io.ktor:ktor-server-netty-jvm")
    implementation("io.ktor:ktor-server-content-negotiation-jvm")
    implementation("io.ktor:ktor-serialization-kotlinx-json-jvm")
    implementation("io.ktor:ktor-server-auth-jvm")
    implementation("io.ktor:ktor-server-auth-jwt-jvm")
    implementation("io.ktor:ktor-client-core")
    implementation("io.ktor:ktor-client-cio")
    implementation("io.ktor:ktor-client-content-negotiation")
    implementation("org.jetbrains.exposed:exposed-core:0.45.0")
    implementation("org.jetbrains.exposed:exposed-jdbc:0.45.0")
    implementation("org.postgresql:postgresql:42.7.1")
    implementation("ch.qos.logback:logback-classic:1.4.14")
    
    testImplementation("io.ktor:ktor-server-tests-jvm")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit")
}
'@
$integrationBuildGradle | Out-File -FilePath "services/integration-hub/build.gradle.kts" -Encoding UTF8

# ========================================
# Node.js Services (MCP, WebSocket)
# ========================================

# MCP Server package.json
$mcpPackageJson = @'
{
  "name": "mary-mcp-server",
  "version": "1.0.0",
  "description": "Mary Platform MCP Server",
  "type": "module",
  "main": "dist/index.js",
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "test": "vitest"
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
    "@types/express": "^4.17.21",
    "typescript": "^5.3.3",
    "tsx": "^4.7.0",
    "vitest": "^1.0.4"
  }
}
'@
$mcpPackageJson | Out-File -FilePath "services/mcp-server/package.json" -Encoding UTF8

# WebSocket Server package.json
$wsPackageJson = @'
{
  "name": "mary-websocket-service",
  "version": "1.0.0",
  "description": "Mary Platform WebSocket Service",
  "type": "module",
  "main": "dist/index.js",
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "test": "vitest"
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
    "@types/express": "^4.17.21",
    "@types/jsonwebtoken": "^9.0.5",
    "typescript": "^5.3.3",
    "tsx": "^4.7.0",
    "vitest": "^1.0.4"
  }
}
'@
$wsPackageJson | Out-File -FilePath "services/websocket/package.json" -Encoding UTF8

# ========================================
# Service READMEs
# ========================================

$services = @(
    @{name="gateway"; desc="API Gateway - Routes and load balances requests"; tech="Rust/Actix"},
    @{name="auth"; desc="Authentication Service - User authentication and authorization"; tech="Rust/Actix"},
    @{name="crm"; desc="CRM Service - Customer relationship management"; tech="Java/Spring Boot"},
    @{name="ai-orchestrator"; desc="AI Orchestrator - Multi-provider AI management"; tech="Java/Spring Boot"},
    @{name="integration-hub"; desc="Integration Hub - Third-party integrations"; tech="Kotlin/Ktor"},
    @{name="payment"; desc="Payment Service - Payment processing"; tech="Rust/Actix"},
    @{name="mcp-server"; desc="MCP Server - Model Context Protocol implementation"; tech="TypeScript/Node.js"},
    @{name="analytics"; desc="Analytics Service - Data analytics and reporting"; tech="Java/Spring Boot"},
    @{name="websocket"; desc="WebSocket Service - Real-time communication"; tech="TypeScript/Node.js"}
)

foreach ($service in $services) {
    $readme = @"
# $($service.name)

$($service.desc)

## Technology

$($service.tech)

## Getting Started

See main README for setup instructions.

## API Documentation

See /docs/api/ for API documentation.
"@
    $readme | Out-File -FilePath "services/$($service.name)/README.md" -Encoding UTF8
}

Write-Host "Service configuration files created successfully!" -ForegroundColor Green