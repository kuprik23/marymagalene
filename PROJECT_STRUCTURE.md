# Mary Platform - Project Structure

**Version:** 1.0.0  
**Last Updated:** 2025-12-25  
**Project Location:** C:\Martin\WEB\Mary

---

## Table of Contents

1. [Overview](#overview)
2. [Root Directory Structure](#root-directory-structure)
3. [Desktop Application](#desktop-application)
4. [Backend Microservices](#backend-microservices)
5. [Native Modules](#native-modules)
6. [Shared Libraries](#shared-libraries)
7. [Infrastructure](#infrastructure)
8. [Documentation](#documentation)
9. [Development Scripts](#development-scripts)

---

## 1. Overview

The Mary platform follows a monorepo structure with clear separation between:
- **Frontend** (Tauri desktop application)
- **Backend** (Microservices in multiple languages)
- **Native** (C++ performance-critical modules)
- **Shared** (Common code and definitions)
- **Infrastructure** (DevOps, deployment, monitoring)

This structure enables independent development and deployment while maintaining code organization.

---

## 2. Root Directory Structure

```
C:\Martin\WEB\Mary\
│
├── .github/                        # GitHub Actions workflows
│   ├── workflows/
│   │   ├── desktop-build.yml
│   │   ├── backend-tests.yml
│   │   ├── security-scan.yml
│   │   └── deploy-production.yml
│   └── CODEOWNERS
│
├── desktop/                        # Tauri Desktop Application
│   ├── src/                       # React/TypeScript frontend
│   ├── src-tauri/                # Rust backend
│   ├── public/                   # Static assets
│   ├── package.json
│   ├── tsconfig.json
│   ├── vite.config.ts
│   └── README.md
│
├── services/                       # Backend Microservices
│   ├── gateway/                   # API Gateway (Rust)
│   ├── auth/                      # Authentication Service (Rust)
│   ├── crm/                       # CRM Service (Java/Spring)
│   ├── ai-orchestrator/           # AI Agent Orchestrator (Java/Spring)
│   ├── integration-hub/           # Integration Hub (Kotlin/Ktor)
│   ├── payment/                   # Payment Service (Rust)
│   ├── mcp-server/                # MCP Server (TypeScript/Node.js)
│   ├── analytics/                 # Analytics Service (Java/Spring)
│   └── websocket/                 # WebSocket Server (TypeScript/Node.js)
│
├── native/                         # C++ Native Modules
│   ├── filesystem/
│   ├── image-processor/
│   ├── video-transcoder/
│   ├── crypto-accelerator/
│   └── CMakeLists.txt
│
├── shared/                         # Shared Libraries and Definitions
│   ├── types/                     # TypeScript type definitions
│   ├── protos/                    # Protocol Buffers definitions
│   ├── schemas/                   # Database schemas and migrations
│   ├── config/                    # Configuration templates
│   └── utils/                     # Shared utilities
│
├── infrastructure/                 # DevOps and Infrastructure
│   ├── docker/                    # Docker configurations
│   ├── kubernetes/                # K8s manifests
│   ├── terraform/                 # Infrastructure as Code
│   ├── monitoring/                # Prometheus, Grafana configs
│   └── scripts/                   # Infrastructure scripts
│
├── docs/                          # Documentation
│   ├── api/                       # API documentation
│   ├── user-guides/               # User documentation
│   ├── developer/                 # Developer guides
│   └── architecture/              # Architecture diagrams
│
├── scripts/                       # Development and Build Scripts
│   ├── build-all.sh
│   ├── test-all.sh
│   ├── deploy.sh
│   └── setup-dev.sh
│
├── tests/                         # End-to-End Tests
│   ├── e2e/                      # Desktop app E2E tests
│   ├── integration/              # Service integration tests
│   └── performance/              # Load and performance tests
│
├── .gitignore
├── .dockerignore
├── .env.example
├── docker-compose.yml             # Development environment
├── docker-compose.prod.yml        # Production configuration
├── LICENSE
├── README.md
├── ARCHITECTURE.md
├── PROJECT_STRUCTURE.md          # This file
├── SECURITY_PLAN.md
└── CHANGELOG.md
```

---

## 3. Desktop Application

### 3.1 Frontend Structure (React/TypeScript)

```
desktop/
├── src/
│   ├── features/                   # Feature-based modules
│   │   │
│   │   ├── auth/                  # Authentication & Authorization
│   │   │   ├── components/
│   │   │   │   ├── LoginForm.tsx
│   │   │   │   ├── RegisterForm.tsx
│   │   │   │   ├── MFASetup.tsx
│   │   │   │   └── ProfileSettings.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useAuth.ts
│   │   │   │   └── usePermissions.ts
│   │   │   ├── services/
│   │   │   │   └── authService.ts
│   │   │   ├── store/
│   │   │   │   └── authSlice.ts
│   │   │   ├── types/
│   │   │   │   └── auth.types.ts
│   │   │   └── index.ts
│   │   │
│   │   ├── ai-orchestrator/       # AI Agent Management
│   │   │   ├── components/
│   │   │   │   ├── AgentList.tsx
│   │   │   │   ├── AgentCreator.tsx
│   │   │   │   ├── AgentConfiguration.tsx
│   │   │   │   ├── ConversationView.tsx
│   │   │   │   ├── ProviderSelector.tsx
│   │   │   │   └── ModelComparison.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useAgents.ts
│   │   │   │   ├── useConversation.ts
│   │   │   │   └── useProviders.ts
│   │   │   ├── services/
│   │   │   │   └── aiService.ts
│   │   │   ├── store/
│   │   │   │   └── aiSlice.ts
│   │   │   └── types/
│   │   │       └── ai.types.ts
│   │   │
│   │   ├── crm/                   # Customer Relationship Management
│   │   │   ├── components/
│   │   │   │   ├── ContactList.tsx
│   │   │   │   ├── ContactDetails.tsx
│   │   │   │   ├── ContactForm.tsx
│   │   │   │   ├── DealPipeline.tsx
│   │   │   │   ├── ActivityTimeline.tsx
│   │   │   │   └── CustomFields.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useContacts.ts
│   │   │   │   ├── useDeals.ts
│   │   │   │   └── useActivities.ts
│   │   │   ├── services/
│   │   │   │   └── crmService.ts
│   │   │   ├── store/
│   │   │   │   └── crmSlice.ts
│   │   │   └── types/
│   │   │       └── crm.types.ts
│   │   │
│   │   ├── social-media/          # Social Media Integration
│   │   │   ├── components/
│   │   │   │   ├── AccountManager.tsx
│   │   │   │   ├── PostComposer.tsx
│   │   │   │   ├── PostScheduler.tsx
│   │   │   │   ├── AnalyticsDashboard.tsx
│   │   │   │   └── PlatformConnector.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useSocialAccounts.ts
│   │   │   │   ├── usePosts.ts
│   │   │   │   └── useAnalytics.ts
│   │   │   ├── services/
│   │   │   │   └── socialService.ts
│   │   │   └── types/
│   │   │       └── social.types.ts
│   │   │
│   │   ├── api-manager/           # Universal API Connection Manager
│   │   │   ├── components/
│   │   │   │   ├── ConnectionList.tsx
│   │   │   │   ├── ConnectionForm.tsx
│   │   │   │   ├── APITester.tsx
│   │   │   │   ├── WebhookManager.tsx
│   │   │   │   └── RequestBuilder.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useConnections.ts
│   │   │   │   └── useAPITest.ts
│   │   │   ├── services/
│   │   │   │   └── apiService.ts
│   │   │   └── types/
│   │   │       └── api.types.ts
│   │   │
│   │   ├── app-integration/       # Computer Apps Integration
│   │   │   ├── components/
│   │   │   │   ├── AppList.tsx
│   │   │   │   ├── AppConnector.tsx
│   │   │   │   ├── AppControls.tsx
│   │   │   │   └── PermissionManager.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useLocalApps.ts
│   │   │   │   └── useAppControl.ts
│   │   │   ├── services/
│   │   │   │   └── appService.ts
│   │   │   └── types/
│   │   │       └── app.types.ts
│   │   │
│   │   ├── client-portal/         # Client-Facing Interface
│   │   │   ├── components/
│   │   │   │   ├── ClientDashboard.tsx
│   │   │   │   ├── ProjectView.tsx
│   │   │   │   ├── InvoiceList.tsx
│   │   │   │   ├── MessageCenter.tsx
│   │   │   │   └── DocumentSharing.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useClientData.ts
│   │   │   │   └── useMessages.ts
│   │   │   ├── services/
│   │   │   │   └── clientService.ts
│   │   │   └── types/
│   │   │       └── client.types.ts
│   │   │
│   │   ├── payments/              # Payment Processing
│   │   │   ├── components/
│   │   │   │   ├── SubscriptionManager.tsx
│   │   │   │   ├── PaymentMethods.tsx
│   │   │   │   ├── InvoiceHistory.tsx
│   │   │   │   ├── PricingTiers.tsx
│   │   │   │   └── CheckoutFlow.tsx
│   │   │   ├── hooks/
│   │   │   │   ├── useSubscription.ts
│   │   │   │   ├── usePayment.ts
│   │   │   │   └── useInvoices.ts
│   │   │   ├── services/
│   │   │   │   └── paymentService.ts
│   │   │   └── types/
│   │   │       └── payment.types.ts
│   │   │
│   │   └── admin/                 # Admin Dashboard
│   │       ├── components/
│   │       │   ├── UserManagement.tsx
│   │       │   ├── SystemMetrics.tsx
│   │       │   ├── AuditLogs.tsx
│   │       │   ├── FeatureFlags.tsx
│   │       │   └── ConfigEditor.tsx
│   │       ├── hooks/
│   │       │   ├── useUsers.ts
│   │       │   ├── useMetrics.ts
│   │       │   └── useLogs.ts
│   │       ├── services/
│   │       │   └── adminService.ts
│   │       └── types/
│   │           └── admin.types.ts
│   │
│   ├── shared/                    # Shared Components and Utilities
│   │   ├── components/
│   │   │   ├── ui/               # Reusable UI components
│   │   │   │   ├── Button.tsx
│   │   │   │   ├── Input.tsx
│   │   │   │   ├── Modal.tsx
│   │   │   │   ├── Dropdown.tsx
│   │   │   │   ├── Table.tsx
│   │   │   │   ├── Card.tsx
│   │   │   │   ├── Badge.tsx
│   │   │   │   ├── Spinner.tsx
│   │   │   │   └── Toast.tsx
│   │   │   ├── layout/           # Layout components
│   │   │   │   ├── Sidebar.tsx
│   │   │   │   ├── Header.tsx
│   │   │   │   ├── Footer.tsx
│   │   │   │   └── MainLayout.tsx
│   │   │   └── common/           # Common components
│   │   │       ├── ErrorBoundary.tsx
│   │   │       ├── LoadingState.tsx
│   │   │       └── EmptyState.tsx
│   │   ├── hooks/
│   │   │   ├── useDebounce.ts
│   │   │   ├── useLocalStorage.ts
│   │   │   ├── useMediaQuery.ts
│   │   │   ├── useTheme.ts
│   │   │   └── useWebSocket.ts
│   │   ├── utils/
│   │   │   ├── formatting.ts
│   │   │   ├── validation.ts
│   │   │   ├── date.ts
│   │   │   ├── currency.ts
│   │   │   └── encryption.ts
│   │   ├── types/
│   │   │   ├── common.types.ts
│   │   │   ├── api.types.ts
│   │   │   └── index.ts
│   │   └── constants/
│   │       ├── routes.ts
│   │       ├── config.ts
│   │       └── api-endpoints.ts
│   │
│   ├── store/                     # State Management (Zustand/Redux)
│   │   ├── index.ts
│   │   ├── rootReducer.ts        # If using Redux
│   │   └── middleware.ts
│   │
│   ├── services/                  # API Client Services
│   │   ├── api/
│   │   │   ├── client.ts         # Axios instance
│   │   │   ├── interceptors.ts   # Request/response interceptors
│   │   │   └── endpoints.ts      # API endpoint definitions
│   │   └── websocket/
│   │       └── client.ts         # WebSocket client
│   │
│   ├── layouts/                   # Page Layouts
│   │   ├── AuthLayout.tsx
│   │   ├── DashboardLayout.tsx
│   │   ├── AdminLayout.tsx
│   │   └── ClientPortalLayout.tsx
│   │
│   ├── routes/                    # Routing Configuration
│   │   ├── index.tsx
│   │   ├── ProtectedRoute.tsx
│   │   └── routes.config.ts
│   │
│   ├── styles/                    # Global Styles
│   │   ├── globals.css
│   │   ├── themes/
│   │   │   ├── light.css
│   │   │   └── dark.css
│   │   └── tailwind.config.js
│   │
│   ├── assets/                    # Static Assets
│   │   ├── images/
│   │   ├── icons/
│   │   └── fonts/
│   │
│   ├── App.tsx                    # Root component
│   ├── main.tsx                   # Entry point
│   └── vite-env.d.ts
│
├── src-tauri/                     # Tauri Backend (Rust)
│   ├── src/
│   │   ├── commands/              # Tauri commands (IPC)
│   │   │   ├── auth.rs           # Authentication commands
│   │   │   ├── filesystem.rs     # File operations
│   │   │   ├── crypto.rs         # Encryption/decryption
│   │   │   ├── system.rs         # System integration
│   │   │   ├── api.rs            # API calls
│   │   │   └── mod.rs
│   │   ├── security/              # Security modules
│   │   │   ├── encryption.rs     # Encryption utilities
│   │   │   ├── certificate.rs    # Certificate management
│   │   │   └── mod.rs
│   │   ├── system/                # System integration
│   │   │   ├── tray.rs           # System tray
│   │   │   ├── notifications.rs  # OS notifications
│   │   │   ├── updater.rs        # Auto-updater
│   │   │   └── mod.rs
│   │   ├── storage/               # Local storage
│   │   │   ├── database.rs       # Local SQLite
│   │   │   ├── cache.rs          # Caching
│   │   │   └── mod.rs
│   │   ├── integration/           # Native integrations
│   │   │   ├── ffi.rs            # C++ FFI
│   │   │   ├── apps.rs           # App integration
│   │   │   └── mod.rs
│   │   ├── utils/                 # Utilities
│   │   │   ├── logger.rs
│   │   │   ├── config.rs
│   │   │   └── mod.rs
│   │   ├── main.rs                # Entry point
│   │   └── lib.rs
│   ├── Cargo.toml
│   ├── Cargo.lock
│   ├── tauri.conf.json            # Tauri configuration
│   └── build.rs
│
├── public/                        # Public assets
│   ├── icons/
│   │   ├── icon.png
│   │   ├── icon.icns             # macOS
│   │   └── icon.ico              # Windows
│   └── splash.png
│
├── tests/                         # Desktop app tests
│   ├── unit/
│   ├── integration/
│   └── e2e/
│
├── .env.example
├── .env.local
├── package.json
├── package-lock.json
├── tsconfig.json
├── tsconfig.node.json
├── vite.config.ts
├── vitest.config.ts
├── tailwind.config.js
├── postcss.config.js
├── .eslintrc.json
├── .prettierrc
└── README.md
```

---

## 4. Backend Microservices

### 4.1 API Gateway (Rust/Actix)

```
services/gateway/
├── src/
│   ├── routes/                    # Route handlers
│   │   ├── auth.rs
│   │   ├── crm.rs
│   │   ├── ai.rs
│   │   ├── integration.rs
│   │   ├── payment.rs
│   │   └── mod.rs
│   ├── middleware/                # Middleware
│   │   ├── auth.rs               # JWT validation
│   │   ├── rate_limit.rs         # Rate limiting
│   │   ├── cors.rs               # CORS handling
│   │   ├── logging.rs            # Request logging
│   │   └── mod.rs
│   ├── proxy/                     # Service proxying
│   │   ├── router.rs
│   │   ├── load_balancer.rs
│   │   └── mod.rs
│   ├── security/                  # Security
│   │   ├── jwt.rs
│   │   ├── encryption.rs
│   │   └── mod.rs
│   ├── config/                    # Configuration
│   │   ├── settings.rs
│   │   ├── env.rs
│   │   └── mod.rs
│   ├── utils/                     # Utilities
│   │   ├── error.rs
│   │   ├── response.rs
│   │   └── mod.rs
│   ├── main.rs
│   └── lib.rs
├── tests/
│   ├── integration/
│   └── unit/
├── Cargo.toml
├── Cargo.lock
├── .env.example
└── README.md
```

### 4.2 Authentication Service (Rust/Actix)

```
services/auth/
├── src/
│   ├── routes/                    # API routes
│   │   ├── register.rs
│   │   ├── login.rs
│   │   ├── refresh.rs
│   │   ├── mfa.rs
│   │   ├── password.rs
│   │   └── mod.rs
│   ├── models/                    # Data models
│   │   ├── user.rs
│   │   ├── session.rs
│   │   ├── token.rs
│   │   └── mod.rs
│   ├── services/                  # Business logic
│   │   ├── auth_service.rs
│   │   ├── token_service.rs
│   │   ├── mfa_service.rs
│   │   └── mod.rs
│   ├── database/                  # Database
│   │   ├── connection.rs
│   │   ├── queries.rs
│   │   └── mod.rs
│   ├── security/                  # Security
│   │   ├── password.rs           # Argon2 hashing
│   │   ├── jwt.rs                # JWT handling
│   │   ├── oauth.rs              # OAuth2/OIDC
│   │   └── mod.rs
│   ├── cache/                     # Redis cache
│   │   ├── session_store.rs
│   │   └── mod.rs
│   ├── config/
│   ├── utils/
│   ├── main.rs
│   └── lib.rs
├── migrations/                    # Database migrations
│   ├── 001_create_users.sql
│   ├── 002_create_sessions.sql
│   └── 003_create_mfa.sql
├── tests/
├── Cargo.toml
└── README.md
```

### 4.3 CRM Service (Java/Spring Boot)

```
services/crm/
├── src/
│   ├── main/
│   │   ├── java/com/mary/crm/
│   │   │   ├── controller/        # REST controllers
│   │   │   │   ├── ContactController.java
│   │   │   │   ├── CompanyController.java
│   │   │   │   ├── DealController.java
│   │   │   │   └── ActivityController.java
│   │   │   ├── service/           # Business logic
│   │   │   │   ├── ContactService.java
│   │   │   │   ├── DealService.java
│   │   │   │   └── ActivityService.java
│   │   │   ├── repository/        # Data access
│   │   │   │   ├── ContactRepository.java
│   │   │   │   ├── DealRepository.java
│   │   │   │   └── ActivityRepository.java
│   │   │   ├── model/             # Entity models
│   │   │   │   ├── Contact.java
│   │   │   │   ├── Company.java
│   │   │   │   ├── Deal.java
│   │   │   │   └── Activity.java
│   │   │   ├── dto/               # Data Transfer Objects
│   │   │   │   ├── ContactDTO.java
│   │   │   │   ├── DealDTO.java
│   │   │   │   └── ActivityDTO.java
│   │   │   ├── security/          # Security configuration
│   │   │   │   ├── SecurityConfig.java
│   │   │   │   └── JwtAuthFilter.java
│   │   │   ├── config/            # Application config
│   │   │   │   ├── DatabaseConfig.java
│   │   │   │   └── CacheConfig.java
│   │   │   ├── exception/         # Exception handling
│   │   │   │   ├── GlobalExceptionHandler.java
│   │   │   │   └── ResourceNotFoundException.java
│   │   │   └── CrmApplication.java
│   │   └── resources/
│   │       ├── application.yml
│   │       ├── application-dev.yml
│   │       ├── application-prod.yml
│   │       └── db/
│   │           └── migration/     # Flyway migrations
│   │               ├── V1__create_contacts.sql
│   │               ├── V2__create_deals.sql
│   │               └── V3__create_activities.sql
│   └── test/
│       └── java/com/mary/crm/
│           ├── controller/
│           ├── service/
│           └── repository/
├── build.gradle                   # or pom.xml for Maven
├── gradle/
├── gradlew
├── gradlew.bat
└── README.md
```

### 4.4 AI Agent Orchestrator (Java/Spring Boot)

```
services/ai-orchestrator/
├── src/
│   ├── main/
│   │   ├── java/com/mary/ai/
│   │   │   ├── controller/
│   │   │   │   ├── AgentController.java
│   │   │   │   ├── ConversationController.java
│   │   │   │   └── ProviderController.java
│   │   │   ├── service/
│   │   │   │   ├── AgentService.java
│   │   │   │   ├── OrchestrationService.java
│   │   │   │   ├── ProviderService.java
│   │   │   │   └── EmbeddingService.java
│   │   │   ├── provider/          # AI provider integrations
│   │   │   │   ├── OpenAIProvider.java
│   │   │   │   ├── AnthropicProvider.java
│   │   │   │   ├── GoogleProvider.java
│   │   │   │   └── ProviderInterface.java
│   │   │   ├── repository/
│   │   │   │   ├── AgentRepository.java
│   │   │   │   └── ConversationRepository.java
│   │   │   ├── model/
│   │   │   │   ├── Agent.java
│   │   │   │   ├── Conversation.java
│   │   │   │   ├── Message.java
│   │   │   │   └── Provider.java
│   │   │   ├── dto/
│   │   │   ├── config/
│   │   │   │   ├── VectorDbConfig.java
│   │   │   │   └── AIProviderConfig.java
│   │   │   ├── vector/            # Vector database
│   │   │   │   ├── VectorStore.java
│   │   │   │   └── EmbeddingGenerator.java
│   │   │   └── AIApplication.java
│   │   └── resources/
│   │       ├── application.yml
│   │       └── db/migration/
│   └── test/
├── build.gradle
└── README.md
```

### 4.5 Integration Hub (Kotlin/Ktor)

```
services/integration-hub/
├── src/
│   ├── main/
│   │   ├── kotlin/com/mary/integration/
│   │   │   ├── routes/            # Ktor routes
│   │   │   │   ├── SocialMediaRoutes.kt
│   │   │   │   ├── APIRoutes.kt
│   │   │   │   └── WebhookRoutes.kt
│   │   │   ├── services/
│   │   │   │   ├── TwitterService.kt
│   │   │   │   ├── LinkedInService.kt
│   │   │   │   ├── FacebookService.kt
│   │   │   │   └── GenericAPIService.kt
│   │   │   ├── models/
│   │   │   │   ├── Connection.kt
│   │   │   │   ├── SocialPost.kt
│   │   │   │   └── APICall.kt
│   │   │   ├── repositories/
│   │   │   │   └── ConnectionRepository.kt
│   │   │   ├── oauth/             # OAuth flows
│   │   │   │   ├── OAuthHandler.kt
│   │   │   │   └── TokenManager.kt
│   │   │   ├── config/
│   │   │   │   ├── DatabaseConfig.kt
│   │   │   │   └── IntegrationConfig.kt
│   │   │   ├── plugins/           # Ktor plugins
│   │   │   │   ├── Routing.kt
│   │   │   │   ├── Serialization.kt
│   │   │   │   └── Security.kt
│   │   │   └── Application.kt
│   │   └── resources/
│   │       ├── application.conf
│   │       └── logback.xml
│   └── test/
│       └── kotlin/com/mary/integration/
├── build.gradle.kts
├── settings.gradle.kts
└── README.md
```

### 4.6 Payment Service (Rust/Actix)

```
services/payment/
├── src/
│   ├── routes/
│   │   ├── subscription.rs
│   │   ├── payment_method.rs
│   │   ├── invoice.rs
│   │   └── webhook.rs
│   ├── services/
│   │   ├── stripe_service.rs
│   │   ├── subscription_service.rs
│   │   └── billing_service.rs
│   ├── models/
│   │   ├── subscription.rs
│   │   ├── payment.rs
│   │   └── invoice.rs
│   ├── database/
│   ├── security/
│   │   ├── webhook_validator.rs
│   │   └── pci_compliance.rs
│   ├── config/
│   ├── main.rs
│   └── lib.rs
├── migrations/
├── tests/
├── Cargo.toml
└── README.md
```

### 4.7 MCP Server (TypeScript/Node.js)

```
services/mcp-server/
├── src/
│   ├── server/                    # MCP server implementation
│   │   ├── MCPServer.ts
│   │   ├── ToolRegistry.ts
│   │   ├── ResourceRegistry.ts
│   │   └── PromptRegistry.ts
│   ├── tools/                     # MCP tools
│   │   ├── crm-tools.ts
│   │   ├── api-tools.ts
│   │   ├── filesystem-tools.ts
│   │   └── index.ts
│   ├── resources/                 # MCP resources
│   │   ├── document-resource.ts
│   │   ├── contact-resource.ts
│   │   └── index.ts
│   ├── prompts/                   # MCP prompts
│   │   ├── agent-prompts.ts
│   │   └── index.ts
│   ├── context/                   # Context management
│   │   ├── ContextManager.ts
│   │   └── MemoryStore.ts
│   ├── config/
│   │   └── config.ts
│   ├── types/
│   │   └── mcp.types.ts
│   └── index.ts
├── tests/
│   ├── unit/
│   └── integration/
├── package.json
├── tsconfig.json
├── .env.example
└── README.md
```

### 4.8 WebSocket Server (TypeScript/Node.js)

```
services/websocket/
├── src/
│   ├── server/
│   │   ├── WebSocketServer.ts
│   │   └── SocketHandler.ts
│   ├── handlers/
│   │   ├── ChatHandler.ts
│   │   ├── NotificationHandler.ts
│   │   └── RealtimeHandler.ts
│   ├── auth/
│   │   └── SocketAuth.ts
│   ├── types/
│   └── index.ts
├── package.json
└── README.md
```

---

## 5. Native Modules

### 5.1 C++ Modules Structure

```
native/
├── filesystem/                    # High-performance file operations
│   ├── src/
│   │   ├── FileSystemOptimizer.cpp
│   │   ├── FileSystemOptimizer.h
│   │   └── bindings.cpp
│   ├── tests/
│   ├── CMakeLists.txt
│   └── README.md
│
├── image-processor/               # Image manipulation
│   ├── src/
│   │   ├── ImageProcessor.cpp
│   │   ├── ImageProcessor.h
│   │   └── bindings.cpp
│   ├── tests/
│   ├── CMakeLists.txt
│   └── README.md
│
├── video-transcoder/              # Video processing
│   ├── src/
│   │   ├── VideoTranscoder.cpp
│   │   ├── VideoTranscoder.h
│   │   └── bindings.cpp
│   ├── tests/
│   ├── CMakeLists.txt
│   └── README.md
│
├── crypto-accelerator/            # Hardware crypto
│   ├── src/
│   │   ├── CryptoAccelerator.cpp
│   │   ├── CryptoAccelerator.h
│   │   └── bindings.cpp
│   ├── tests/
│   ├── CMakeLists.txt
│   └── README.md
│
├── shared/                        # Shared utilities
│   ├── include/
│   │   └── common.h
│   └── src/
│       └── utils.cpp
│
├── CMakeLists.txt                 # Root CMake file
├── vcpkg.json                     # C++ dependencies
└── README.md
```

---

## 6. Shared Libraries

```
shared/
├── types/                         # TypeScript type definitions
│   ├── api/
│   │   ├── auth.types.ts
│   │   ├── crm.types.ts
│   │   ├── ai.types.ts
│   │   └── index.ts
│   ├── models/
│   │   ├── user.types.ts
│   │   ├── subscription.types.ts
│   │   └── index.ts
│   └── index.ts
│
├── protos/                        # Protocol Buffers
│   ├── auth.proto
│   ├── crm.proto
│   ├── ai.proto
│   └── build.sh
│
├── schemas/                       # Database schemas
│   ├── postgresql/
│   │   ├── 001_initial_schema.sql
│   │   ├── 002_add_subscriptions.sql
│   │   └── migrations.md
│   ├── mongodb/
│   │   └── collections.json
│   └── redis/
│       └── keys.md
│
├── config/                        # Configuration templates
│   ├── app.config.example.json
│   ├── database.config.example.json
│   └── api.config.example.json
│
└── utils/                         # Shared utilities
    ├── typescript/
    │   ├── validation.ts
    │   ├── formatting.ts
    │   └── error-handling.ts
    ├── rust/
    │   └── common.rs
    └── java/
        └── CommonUtils.java
```

---

## 7. Infrastructure

```
infrastructure/
├── docker/                        # Docker configurations
│   ├── desktop/
│   │   └── Dockerfile
│   ├── gateway/
│   │   └── Dockerfile
│   ├── auth/
│   │   └── Dockerfile
│   ├── crm/
│   │   └── Dockerfile
│   ├── ai-orchestrator/
│   │   └── Dockerfile
│   ├── integration-hub/
│   │   └── Dockerfile
│   ├── payment/
│   │   └── Dockerfile
│   ├── mcp-server/
│   │   └── Dockerfile
│   └── .dockerignore
│
├── kubernetes/                    # Kubernetes manifests
│   ├── namespaces/
│   │   ├── dev.yaml
│   │   ├── staging.yaml
│   │   └── prod.yaml
│   ├── deployments/
│   │   ├── gateway.yaml
│   │   ├── auth.yaml
│   │   ├── crm.yaml
│   │   ├── ai-orchestrator.yaml
│   │   └── integration-hub.yaml
│   ├── services/
│   │   ├── gateway-service.yaml
│   │   └── internal-services.yaml
│   ├── ingress/
│   │   ├── ingress.yaml
│   │   └── tls-cert.yaml
│   ├── configmaps/
│   │   └── app-config.yaml
│   ├── secrets/
│   │   └── secrets.example.yaml
│   ├── persistent-volumes/
│   │   ├── postgres-pv.yaml
│   │   └── redis-pv.yaml
│   └── autoscaling/
│       └── hpa.yaml
│
├── terraform/                     # Infrastructure as Code
│   ├── aws/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── vpc.tf
│   │   ├── eks.tf
│   │   ├── rds.tf
│   │   └── s3.tf
│   ├── azure/
│   │   └── main.tf
│   ├── gcp/
│   │   └── main.tf
│   └── modules/
│       ├── database/
│       ├── compute/
│       └── networking/
│
├── monitoring/                    # Monitoring configs
│   ├── prometheus/
│   │   ├── prometheus.yml
│   │   ├── alerts.yml
│   │   └── rules.yml
│   ├── grafana/
│   │   ├── dashboards/
│   │   │   ├── system-overview.json
│   │   │   ├── api-metrics.json
│   │   │   └── business-metrics.json
│   │   └── datasources.yml
│   ├── elk/
│   │   ├── elasticsearch.yml
│   │   ├── logstash.conf
│   │   └── kibana.yml
│   └── sentry/
│       └── sentry.properties
│
└── scripts/                       # Infrastructure scripts
    ├── setup-cluster.sh
    ├── deploy.sh
    ├── rollback.sh
    ├── backup.sh
    └── restore.sh
```

---

## 8. Documentation

```
docs/
├── api/                           # API documentation
│   ├── openapi/
│   │   ├── auth-api.yaml
│   │   ├── crm-api.yaml
│   │   ├── ai-api.yaml
│   │   └── payment-api.yaml
│   ├── postman/
│   │   └── Mary-Platform.postman_collection.json
│   └── README.md
│
├── user-guides/                   # User documentation
│   ├── getting-started.md
│   ├── ai-agents.md
│   ├── crm-guide.md
│   ├── social-media.md
│   ├── api-connections.md
│   └── faq.md
│
├── developer/                     # Developer guides
│   ├── setup.md
│   ├── contributing.md
│   ├── code-style.md
│   ├── testing.md
│   ├── deployment.md
│   └── troubleshooting.md
│
└── architecture/                  # Architecture docs
    ├── diagrams/
    │   ├── system-architecture.png
    │   ├── database-schema.png
    │   └── deployment-diagram.png
    ├── decisions/                 # Architecture Decision Records
    │   ├── 001-tauri-vs-electron.md
    │   ├── 002-microservices.md
    │   └── 003-multi-language.md
    └── README.md
```

---

## 9. Development Scripts

```
scripts/
├── build-all.sh                   # Build all services
├── build-desktop.sh               # Build desktop app
├── build-services.sh              # Build backend services
├── build-native.sh                # Build C++ modules
├── test-all.sh                    # Run all tests
├── test-unit.sh                   # Unit tests only
├── test-integration.sh            # Integration tests
├── test-e2e.sh                    # E2E tests
├── deploy.sh                      # Deploy to production
├── deploy-staging.sh              # Deploy to staging
├── setup-dev.sh                   # Setup dev environment
├── clean.sh                       # Clean build artifacts
├── migrate-db.sh                  # Run database migrations
├── seed-db.sh                     # Seed database with test data
└── README.md
```

---

## 10. Configuration Files

### 10.1 Root Level Config Files

```
C:\Martin\WEB\Mary\
├── .gitignore                     # Git ignore rules
├── .dockerignore                  # Docker ignore rules
├── .editorconfig                  # Editor configuration
├── .env.example                   # Environment variables template
├── docker-compose.yml             # Development environment
├── docker-compose.prod.yml        # Production config
├── Makefile                       # Build automation
└── package.json                   # Root package.json (for monorepo tools)
```

### 10.2 Example .gitignore

```
# Dependencies
node_modules/
target/
build/
dist/
out/
.gradle/

# Environment files
.env
.env.local
.env.*.local

# IDE
.idea/
.vscode/
*.swp
*.swo
.DS_Store

# Build artifacts
*.log
*.exe
*.dll
*.so
*.dylib

# Rust
Cargo.lock
target/

# Java
*.class
*.jar
!gradle-wrapper.jar

# TypeScript
*.tsbuildinfo

# C++
*.o
*.obj
CMakeCache.txt
CMakeFiles/
```

---

## 11. Testing Structure

```
tests/
├── e2e/                           # End-to-End tests
│   ├── desktop/
│   │   ├── auth.spec.ts
│   │   ├── crm.spec.ts
│   │   ├── ai-agents.spec.ts
│   │   └── payment.spec.ts
│   └── playwright.config.ts
│
├── integration/                   # Integration tests
│   ├── api/
│   │   ├── auth-api.test.ts
│   │   ├── crm-api.test.ts
│   │   └── payment-api.test.ts
│   └── services/
│       ├── gateway-auth.test.ts
│       └── ai-crm.test.ts
│
├── performance/                   # Performance tests
│   ├── load-tests/
│   │   ├── api-load.js           # K6 scripts
│   │   └── websocket-load.js
│   └── stress-tests/
│       └── stress-test.jmx       # JMeter config
│
└── security/                      # Security tests
    ├── penetration/
    └── vulnerability-scan/
```

---

## 12. Database Migration Structure

### 12.1 PostgreSQL Migrations

```
shared/schemas/postgresql/
├── migrations/
│   ├── V001__initial_schema.sql
│   ├── V002__add_users_table.sql
│   ├── V003__add_contacts_table.sql
│   ├── V004__add_deals_table.sql
│   ├── V005__add_ai_agents_table.sql
│   ├── V006__add_subscriptions.sql
│   └── V007__add_indexes.sql
└── seeds/
    ├── dev/
    │   ├── 001_seed_users.sql
    │   └── 002_seed_contacts.sql
    └── test/
        └── 001_test_data.sql
```

---

## Summary

This project structure follows industry best practices:

1. **Monorepo Architecture**: All code in one repository for easier management
2. **Feature-Based Organization**: Frontend organized by features, not technical layers
3. **Clear Separation**: Desktop, backend, native, and infrastructure clearly separated
4. **Technology Isolation**: Each service uses its optimal technology stack
5. **Shared Code**: Common code in `shared/` to avoid duplication
6. **Configuration Management**: Environment-specific configs for dev/staging/prod
7. **Testing Strategy**: Comprehensive testing at all levels
8. **Documentation**: Well-organized docs for users and developers
9. **DevOps Ready**: Docker, Kubernetes, and CI/CD configurations included
10. **Scalability**: Structure supports horizontal scaling and microservices

**Total Project Size Estimate:**
- **Lines of Code**: ~150,000-200,000 LOC
- **Number of Files**: ~800-1,000 files
- **Development Effort**: 6-9 months with 4-6 developers

**Next Steps:**
1. Review and approve this structure
2. Initialize Git repository
3. Create initial folder structure
4. Set up development environment
5. Begin Phase 1 implementation

---

**Document Version:** 1.0.0  
**Last Updated:** 2025-12-25  
**Author:** Technical Architecture Team  
**Status:** Draft - Awaiting Approval