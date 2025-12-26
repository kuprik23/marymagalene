# Mary Platform - Security Plan

**Version:** 1.0.0  
**Last Updated:** 2025-12-25  
**Classification:** Confidential  
**Project Location:** C:\Martin\WEB\Mary

---

## Table of Contents

1. [Security Overview](#security-overview)
2. [Threat Model](#threat-model)
3. [Authentication & Authorization](#authentication--authorization)
4. [Data Protection](#data-protection)
5. [API Security](#api-security)
6. [Payment Security (PCI-DSS)](#payment-security-pci-dss)
7. [Network Security](#network-security)
8. [Application Security](#application-security)
9. [Database Security](#database-security)
10. [Infrastructure Security](#infrastructure-security)
11. [Third-Party Integration Security](#third-party-integration-security)
12. [Secrets Management](#secrets-management)
13. [Security Monitoring & Incident Response](#security-monitoring--incident-response)
14. [Compliance & Auditing](#compliance--auditing)
15. [Security Testing Strategy](#security-testing-strategy)
16. [Security Training & Awareness](#security-training--awareness)

---

## 1. Security Overview

### 1.1 Security Principles

The Mary platform is built on the following security principles:

1. **Defense in Depth**: Multiple layers of security controls
2. **Least Privilege**: Minimal access rights for users and services
3. **Zero Trust**: Never trust, always verify
4. **Security by Design**: Security integrated from the start
5. **Privacy by Default**: User data protection as default behavior
6. **Fail Secure**: Systems fail in a secure state
7. **Continuous Monitoring**: Real-time security monitoring
8. **Incident Response Ready**: Prepared for security incidents

### 1.2 Security Architecture Overview

```mermaid
graph TB
    subgraph "External Layer"
        Client[Desktop Client]
        Internet[Internet]
    end
    
    subgraph "Edge Security"
        WAF[Web Application Firewall]
        DDoS[DDoS Protection]
        CDN[CDN with TLS]
    end
    
    subgraph "Application Layer Security"
        APIGateway[API Gateway<br/>- Rate Limiting<br/>- JWT Validation<br/>- Input Validation]
        AuthService[Auth Service<br/>- MFA<br/>- OAuth2/OIDC]
    end
    
    subgraph "Service Mesh Security"
        Services[Microservices<br/>- mTLS<br/>- Service-to-Service Auth<br/>- Encryption]
    end
    
    subgraph "Data Layer Security"
        EncryptedDB[(Encrypted Databases<br/>- AES-256<br/>- Field-level Encryption)]
        Vault[Secrets Vault<br/>- HashiCorp Vault]
    end
    
    Client -->|TLS 1.3| Internet
    Internet --> WAF
    WAF --> DDoS
    DDoS --> CDN
    CDN --> APIGateway
    APIGateway --> AuthService
    APIGateway --> Services
    Services --> EncryptedDB
    Services --> Vault
```

### 1.3 Security Goals

| Goal | Target | Priority |
|------|--------|----------|
| Data Breach Prevention | 0 incidents | Critical |
| Authentication Security | MFA adoption > 80% | High |
| API Security | 0 unauthorized access | Critical |
| PCI-DSS Compliance | Level 1 certification | Critical |
| Vulnerability Patching | < 48 hours for critical | High |
| Security Incident Response | < 1 hour detection | High |
| Data Encryption | 100% sensitive data | Critical |
| Security Audit Pass Rate | > 95% | High |

---

## 2. Threat Model

### 2.1 Assets to Protect

| Asset | Sensitivity | Impact if Compromised |
|-------|-------------|----------------------|
| User credentials | Critical | Account takeover, data breach |
| Payment information | Critical | Financial loss, PCI violation |
| AI agent configurations | High | IP theft, competitive disadvantage |
| Customer data (CRM) | High | Privacy violation, GDPR breach |
| API keys & secrets | Critical | Unauthorized access, data breach |
| Source code | Medium | IP theft, vulnerability exposure |
| Business analytics | Medium | Competitive disadvantage |

### 2.2 Threat Actors

| Actor Type | Motivation | Capability | Likelihood |
|------------|------------|------------|------------|
| Cybercriminals | Financial gain | High | High |
| Competitors | Business advantage | Medium | Medium |
| Insider threats | Various | Medium | Low |
| Nation-state actors | Espionage | Very High | Low |
| Script kiddies | Recognition | Low | Medium |

### 2.3 Attack Vectors

#### 2.3.1 External Threats

- **SQL Injection**: Malicious SQL queries via user input
- **XSS (Cross-Site Scripting)**: Injecting malicious scripts
- **CSRF (Cross-Site Request Forgery)**: Unauthorized actions
- **DDoS Attacks**: Service disruption
- **Man-in-the-Middle**: Intercepting communications
- **Brute Force**: Password guessing attacks
- **API Abuse**: Unauthorized API usage
- **Credential Stuffing**: Using leaked credentials

#### 2.3.2 Internal Threats

- **Privilege Escalation**: Gaining unauthorized access
- **Data Exfiltration**: Stealing sensitive data
- **Insider Abuse**: Malicious employee actions
- **Social Engineering**: Phishing, pretexting

#### 2.3.3 Application-Level Threats

- **Insecure Direct Object References (IDOR)**
- **Business Logic Flaws**
- **Insufficient Logging & Monitoring**
- **Security Misconfiguration**
- **Sensitive Data Exposure**

### 2.4 STRIDE Analysis

| Threat | Mitigation |
|--------|------------|
| **Spoofing** | Strong authentication, MFA, certificate pinning |
| **Tampering** | Input validation, integrity checks, signed requests |
| **Repudiation** | Audit logging, digital signatures, non-repudiation |
| **Information Disclosure** | Encryption, access controls, secure communication |
| **Denial of Service** | Rate limiting, DDoS protection, resource limits |
| **Elevation of Privilege** | Least privilege, role-based access, privilege monitoring |

---

## 3. Authentication & Authorization

### 3.1 Authentication Architecture

```mermaid
sequenceDiagram
    participant U as User
    participant D as Desktop App
    participant A as Auth Service
    participant R as Redis
    participant DB as PostgreSQL
    
    U->>D: Enter credentials
    D->>A: POST /auth/login
    A->>DB: Verify user
    DB->>A: User data
    A->>A: Verify password (Argon2)
    alt MFA Enabled
        A->>U: Request MFA code
        U->>A: Submit MFA code
        A->>A: Verify TOTP/SMS
    end
    A->>A: Generate JWT (RS256)
    A->>R: Store refresh token
    A->>D: Return tokens
    D->>D: Store tokens securely
```

### 3.2 Authentication Methods

#### 3.2.1 Primary Authentication

**Password-Based Authentication:**
- **Hashing Algorithm**: Argon2id
- **Salt**: 16-byte random salt per user
- **Iterations**: 3 iterations
- **Memory**: 64 MB
- **Parallelism**: 4 threads
- **Output**: 32-byte hash

**Implementation (Rust):**
```rust
use argon2::{
    password_hash::{rand_core::OsRng, PasswordHash, PasswordHasher, PasswordVerifier, SaltString},
    Argon2,
};

pub fn hash_password(password: &str) -> Result<String, Error> {
    let salt = SaltString::generate(&mut OsRng);
    let argon2 = Argon2::default();
    let password_hash = argon2
        .hash_password(password.as_bytes(), &salt)?
        .to_string();
    Ok(password_hash)
}

pub fn verify_password(password: &str, hash: &str) -> Result<bool, Error> {
    let parsed_hash = PasswordHash::new(hash)?;
    Ok(Argon2::default()
        .verify_password(password.as_bytes(), &parsed_hash)
        .is_ok())
}
```

#### 3.2.2 Multi-Factor Authentication (MFA)

**Supported Methods:**
1. **TOTP (Time-based One-Time Password)**: Google Authenticator, Authy
2. **SMS**: Text message verification
3. **Email**: Email verification code
4. **Hardware Keys**: YubiKey, WebAuthn/FIDO2

**TOTP Implementation:**
- Algorithm: HMAC-SHA1
- Digits: 6
- Period: 30 seconds
- Window: ±1 period (to account for time drift)

#### 3.2.3 OAuth 2.0 / OpenID Connect

**Supported Flows:**
- Authorization Code Flow (PKCE)
- Client Credentials Flow (service-to-service)
- Refresh Token Flow

**Providers:**
- Google
- Microsoft
- GitHub
- Enterprise SSO (SAML)

### 3.3 JSON Web Tokens (JWT)

**Token Structure:**

**Access Token:**
- **Algorithm**: RS256 (RSA Signature with SHA-256)
- **Lifetime**: 15 minutes
- **Claims**:
  ```json
  {
    "sub": "user-uuid",
    "email": "user@example.com",
    "roles": ["user", "crm-admin"],
    "tier": "professional",
    "iat": 1640000000,
    "exp": 1640000900,
    "iss": "https://api.mary.io",
    "aud": "mary-desktop-app"
  }
  ```

**Refresh Token:**
- **Storage**: Redis (encrypted)
- **Lifetime**: 7 days
- **Rotation**: New token issued on each refresh
- **Revocation**: Immediate via Redis deletion

**Key Management:**
- **Key Generation**: RSA-2048 key pair
- **Key Rotation**: Every 90 days
- **Key Storage**: HashiCorp Vault
- **Algorithm**: RS256 (not HS256)

**Implementation (Rust):**
```rust
use jsonwebtoken::{encode, decode, Header, Validation, Algorithm, EncodingKey, DecodingKey};
use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
struct Claims {
    sub: String,
    email: String,
    roles: Vec<String>,
    tier: String,
    exp: usize,
    iat: usize,
}

pub fn create_jwt(user_id: &str, email: &str, roles: Vec<String>) -> Result<String, Error> {
    let expiration = Utc::now()
        .checked_add_signed(Duration::minutes(15))
        .unwrap()
        .timestamp() as usize;
    
    let claims = Claims {
        sub: user_id.to_owned(),
        email: email.to_owned(),
        roles,
        tier: "professional".to_owned(),
        exp: expiration,
        iat: Utc::now().timestamp() as usize,
    };
    
    let header = Header::new(Algorithm::RS256);
    encode(&header, &claims, &EncodingKey::from_rsa_pem(PRIVATE_KEY)?)
}

pub fn verify_jwt(token: &str) -> Result<Claims, Error> {
    let validation = Validation::new(Algorithm::RS256);
    let token_data = decode::<Claims>(
        token,
        &DecodingKey::from_rsa_pem(PUBLIC_KEY)?,
        &validation,
    )?;
    Ok(token_data.claims)
}
```

### 3.4 Authorization

**Authorization Model**: Role-Based Access Control (RBAC) + Attribute-Based Access Control (ABAC)

#### 3.4.1 Roles

| Role | Permissions | Tier Restriction |
|------|-------------|------------------|
| **User** | Basic access | All tiers |
| **Power User** | Advanced features | Professional+ |
| **Admin** | User management | Enterprise |
| **Super Admin** | System configuration | N/A |
| **CRM Manager** | CRM full access | Professional+ |
| **AI Operator** | AI agent management | All tiers |
| **Client** | Client portal only | N/A |

#### 3.4.2 Permissions

```typescript
enum Permission {
  // User Management
  USER_READ = "user:read",
  USER_CREATE = "user:create",
  USER_UPDATE = "user:update",
  USER_DELETE = "user:delete",
  
  // CRM
  CONTACT_READ = "contact:read",
  CONTACT_CREATE = "contact:create",
  CONTACT_UPDATE = "contact:update",
  CONTACT_DELETE = "contact:delete",
  
  // AI Agents
  AGENT_READ = "agent:read",
  AGENT_CREATE = "agent:create",
  AGENT_EXECUTE = "agent:execute",
  AGENT_DELETE = "agent:delete",
  
  // Admin
  SYSTEM_CONFIG = "system:config",
  AUDIT_READ = "audit:read",
}
```

#### 3.4.3 Permission Enforcement

**Backend (Rust):**
```rust
use actix_web::{web, HttpRequest, HttpResponse};

#[derive(Debug)]
pub struct RequirePermission {
    permission: String,
}

impl RequirePermission {
    pub fn new(permission: &str) -> Self {
        Self {
            permission: permission.to_string(),
        }
    }
}

pub async fn check_permission(req: HttpRequest, required: &str) -> Result<(), Error> {
    let claims = extract_claims(&req)?;
    
    if !claims.roles.iter().any(|role| has_permission(role, required)) {
        return Err(Error::Unauthorized("Insufficient permissions"));
    }
    
    Ok(())
}
```

**Frontend (TypeScript):**
```typescript
const usePermission = (permission: string): boolean => {
  const user = useAuthStore(state => state.user);
  return user?.permissions?.includes(permission) ?? false;
};

// Usage
const ProtectedButton = () => {
  const canCreate = usePermission('contact:create');
  
  return canCreate ? (
    <Button onClick={createContact}>Create Contact</Button>
  ) : null;
};
```

### 3.5 Session Management

**Session Storage**: Redis

**Session Data Structure:**
```json
{
  "session_id": "uuid-v4",
  "user_id": "user-uuid",
  "created_at": "2025-12-25T00:00:00Z",
  "last_activity": "2025-12-25T00:15:00Z",
  "ip_address": "192.168.1.1",
  "user_agent": "Mary Desktop/1.0.0",
  "device_fingerprint": "hash",
  "mfa_verified": true
}
```

**Session Security:**
- **Timeout**: 30 minutes inactivity
- **Absolute Timeout**: 8 hours
- **Concurrent Sessions**: Max 3 devices
- **Session Fixation Prevention**: New session ID after login
- **Session Hijacking Prevention**: Device fingerprinting, IP validation

---

## 4. Data Protection

### 4.1 Encryption Standards

#### 4.1.1 Data at Rest

**Database Encryption:**
- **Algorithm**: AES-256-GCM
- **Key Size**: 256 bits
- **Mode**: Galois/Counter Mode (authenticated encryption)
- **Key Rotation**: Every 90 days
- **Key Management**: HashiCorp Vault

**PostgreSQL Encryption:**
```sql
-- Enable transparent data encryption (TDE)
CREATE EXTENSION pgcrypto;

-- Field-level encryption for sensitive data
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    ssn BYTEA, -- Encrypted field
    credit_card_token BYTEA -- Encrypted field
);

-- Encryption function
CREATE OR REPLACE FUNCTION encrypt_data(data TEXT, key TEXT)
RETURNS BYTEA AS $$
BEGIN
    RETURN pgp_sym_encrypt(data, key, 'cipher-algo=aes256');
END;
$$ LANGUAGE plpgsql;

-- Decryption function
CREATE OR REPLACE FUNCTION decrypt_data(data BYTEA, key TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN pgp_sym_decrypt(data, key);
END;
$$ LANGUAGE plpgsql;
```

**File System Encryption:**
- Desktop app local storage: OS-level encryption (Windows EFS, macOS FileVault)
- Server storage: LUKS (Linux Unified Key Setup)
- Backup encryption: AES-256

#### 4.1.2 Data in Transit

**TLS Configuration:**
- **Protocol**: TLS 1.3 (minimum TLS 1.2)
- **Cipher Suites**:
  ```
  TLS_AES_256_GCM_SHA384
  TLS_CHACHA20_POLY1305_SHA256
  TLS_AES_128_GCM_SHA256
  ```
- **Key Exchange**: ECDHE (Elliptic Curve Diffie-Hellman Ephemeral)
- **Certificate**: 2048-bit RSA or 256-bit ECC
- **HSTS**: Enabled with max-age=31536000

**Nginx Configuration:**
```nginx
ssl_protocols TLSv1.3 TLSv1.2;
ssl_ciphers 'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256';
ssl_prefer_server_ciphers on;
ssl_session_cache shared:SSL:10m;
ssl_session_timeout 10m;
ssl_stapling on;
ssl_stapling_verify on;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
```

**Certificate Pinning (Desktop App):**
```rust
// Tauri config
use tauri::http::ClientBuilder;

pub fn create_http_client() -> Result<Client, Error> {
    let cert = include_bytes!("../certs/api.mary.io.crt");
    
    ClientBuilder::new()
        .add_root_certificate(Certificate::from_pem(cert)?)
        .build()
}
```

#### 4.1.3 End-to-End Encryption (E2EE)

**Use Cases:**
- Sensitive messages between users
- Private notes and documents
- AI conversation history (optional)

**Implementation**:
- **Algorithm**: X25519 (key exchange) + XChaCha20-Poly1305 (encryption)
- **Library**: libsodium
- **Key Storage**: Local only (never sent to server)

### 4.2 Data Classification

| Classification | Examples | Protection Level |
|----------------|----------|------------------|
| **Public** | Marketing materials | None |
| **Internal** | Business analytics | TLS, access control |
| **Confidential** | Customer data, emails | TLS, encryption at rest, access logs |
| **Restricted** | Passwords, payment info | TLS, field-level encryption, strict access control |

### 4.3 Data Retention & Disposal

**Retention Policies:**
- **User data**: Until account deletion + 30 days
- **Audit logs**: 7 years (compliance)
- **Session data**: 8 hours after logout
- **Backups**: 30 days

**Secure Deletion:**
- **Method**: Cryptographic erasure (delete encryption keys)
- **Database**: `DELETE` followed by `VACUUM FULL`
- **Files**: 7-pass DoD 5220.22-M overwrite
- **Compliance**: GDPR "Right to be forgotten"

### 4.4 Personal Data Protection (GDPR)

**Data Subject Rights:**
1. **Right to Access**: Export user data (JSON/CSV)
2. **Right to Rectification**: User can update their data
3. **Right to Erasure**: Account deletion process
4. **Right to Data Portability**: Download all user data
5. **Right to Object**: Opt-out of data processing

**Consent Management:**
- Explicit consent for data processing
- Granular consent options
- Easy consent withdrawal
- Consent audit trail

**Data Minimization:**
- Collect only necessary data
- Delete data when no longer needed
- Anonymize data when possible

---

## 5. API Security

### 5.1 API Gateway Security

**Security Controls:**
1. **Authentication**: JWT validation
2. **Rate Limiting**: Per user and per IP
3. **Input Validation**: Schema validation
4. **Output Encoding**: Prevent XSS
5. **CORS**: Strict origin policy
6. **API Keys**: For programmatic access

**Rate Limiting Strategy:**

| Tier | Requests/Minute | Requests/Hour | Requests/Day |
|------|-----------------|---------------|--------------|
| Free | 30 | 1,000 | 10,000 |
| Professional | 100 | 5,000 | 100,000 |
| Enterprise | 500 | 25,000 | Unlimited |

**Implementation (Rust/Actix):**
```rust
use actix_governor::{Governor, GovernorConfigBuilder};
use std::time::Duration;

pub fn rate_limiter() -> Governor {
    Governor::new(
        &GovernorConfigBuilder::default()
            .per_second(2)
            .burst_size(10)
            .finish()
            .unwrap(),
    )
}

// Usage
App::new()
    .wrap(rate_limiter())
    .service(api_routes)
```

### 5.2 Input Validation

**Validation Rules:**
- **Type Checking**: Ensure correct data types
- **Range Validation**: Min/max values
- **Format Validation**: Email, phone, URL patterns
- **Length Limits**: Prevent buffer overflows
- **Whitelist Approach**: Allow known-good inputs

**Example (TypeScript with Zod):**
```typescript
import { z } from 'zod';

const ContactSchema = z.object({
  email: z.string().email().max(255),
  name: z.string().min(1).max(100),
  phone: z.string().regex(/^\+?[1-9]\d{1,14}$/),
  company: z.string().max(255).optional(),
});

// Usage
const validateContact = (data: unknown) => {
  return ContactSchema.parse(data);
};
```

**SQL Injection Prevention:**
- **Parameterized Queries**: Always use prepared statements
- **ORM Usage**: Hibernate, SQLx, TypeORM
- **Input Sanitization**: Escape special characters

**Example (Rust with SQLx):**
```rust
// SAFE: Parameterized query
let user = sqlx::query_as::<_, User>(
    "SELECT * FROM users WHERE email = $1"
)
.bind(&email)
.fetch_one(&pool)
.await?;

// UNSAFE: String concatenation (NEVER DO THIS)
// let query = format!("SELECT * FROM users WHERE email = '{}'", email);
```

### 5.3 XSS Prevention

**Content Security Policy (CSP):**
```http
Content-Security-Policy: 
  default-src 'self'; 
  script-src 'self' 'unsafe-inline' 'unsafe-eval'; 
  style-src 'self' 'unsafe-inline'; 
  img-src 'self' data: https:; 
  font-src 'self'; 
  connect-src 'self' https://api.mary.io wss://ws.mary.io;
  frame-ancestors 'none';
```

**Output Encoding:**
- HTML encoding: `&lt;` `&gt;` `&amp;` `&quot;` `&#x27;`
- JavaScript encoding: Escape quotes and backslashes
- URL encoding: Percent-encode special characters

**React Automatic Escaping:**
```typescript
// SAFE: React automatically escapes
const UserProfile = ({ name }: { name: string }) => {
  return <div>{name}</div>; // Escaped by React
};

// UNSAFE: dangerouslySetInnerHTML
const UnsafeComponent = ({ html }: { html: string }) => {
  return <div dangerouslySetInnerHTML={{ __html: html }} />; // Avoid!
};
```

### 5.4 CSRF Prevention

**Mitigation Strategies:**
1. **CSRF Tokens**: Synchronizer token pattern
2. **SameSite Cookies**: `SameSite=Strict`
3. **Origin/Referer Validation**: Check request origin
4. **Custom Headers**: Require `X-Requested-With`

**Implementation:**
```rust
use actix_web::middleware::Csrf;

App::new()
    .wrap(Csrf::new())
    .service(api_routes)
```

### 5.5 API Versioning

**Versioning Strategy:** URL-based versioning

**Format:** `https://api.mary.io/v1/resource`

**Deprecation Policy:**
- 6 months notice for breaking changes
- 2 versions supported simultaneously
- Clear migration documentation

---

## 6. Payment Security (PCI-DSS)

### 6.1 PCI-DSS Compliance Level 1

**Scope**: Handling 6M+ transactions annually

**Requirements:**

| Requirement | Implementation |
|-------------|----------------|
| **1. Firewall Protection** | AWS WAF, network segmentation |
| **2. Default Passwords** | Changed, strong passwords enforced |
| **3. Cardholder Data Protection** | No storage, Stripe tokenization |
| **4. Data Encryption** | TLS 1.3, AES-256 |
| **5. Anti-Virus** | ClamAV, endpoint protection |
| **6. Secure Systems** | Regular patching, hardening |
| **7. Access Restriction** | Need-to-know basis, RBAC |
| **8. Access Control** | Unique IDs, MFA |
| **9. Physical Access** | Cloud provider controls |
| **10. Monitoring** | Comprehensive logging |
| **11. Security Testing** | Quarterly scans, annual penetration tests |
| **12. Security Policy** | Documented, reviewed annually |

### 6.2 Stripe Integration Security

**Tokenization:**
- **No raw card data**: Never touches Mary servers
- **Stripe.js**: Client-side tokenization
- **Payment Intents**: SCA-ready (Strong Customer Authentication)

**Implementation:**
```typescript
// Frontend
import { loadStripe } from '@stripe/stripe-js';
const stripe = await loadStripe(PUBLISHABLE_KEY);

const { paymentIntent, error } = await stripe.confirmCardPayment(
  clientSecret,
  {
    payment_method: {
      card: cardElement,
      billing_details: { name: 'Customer Name' },
    },
  }
);
```

**Webhook Security:**
```rust
use stripe::{Webhook, WebhookEvent};

pub async fn handle_webhook(
    req: HttpRequest,
    body: String,
) -> Result<HttpResponse, Error> {
    let signature = req
        .headers()
        .get("stripe-signature")
        .ok_or(Error::MissingSignature)?
        .to_str()?;
    
    let event = Webhook::construct_event(
        &body,
        signature,
        &WEBHOOK_SECRET,
    )?;
    
    match event.type_ {
        EventType::PaymentIntentSucceeded => {
            // Activate subscription
        }
        EventType::SubscriptionDeleted => {
            // Deactivate subscription
        }
        _ => {}
    }
    
    Ok(HttpResponse::Ok().finish())
}
```

### 6.3 Payment Data Handling

**What We Store:**
- Stripe Customer ID
- Subscription ID
- Invoice IDs
- Payment status

**What We NEVER Store:**
- Full card numbers
- CVV/CVC codes
- Card expiry dates
- Card PINs

**Audit Trail:**
- All payment operations logged
- Log retention: 7 years
- Encrypted log storage

---

## 7. Network Security

### 7.1 Network Architecture

```mermaid
graph TB
    subgraph "Public Zone - DMZ"
        LB[Load Balancer]
        WAF[WAF]
    end
    
    subgraph "Application Zone"
        API[API Gateway]
        Services[Microservices]
    end
    
    subgraph "Data Zone"
        DB[(Databases)]
        Cache[(Redis)]
    end
    
    subgraph "Management Zone"
        Monitoring[Monitoring]
        Vault[Secrets Vault]
    end
    
    Internet --> WAF
    WAF --> LB
    LB --> API
    API --> Services
    Services --> DB
    Services --> Cache
    Services --> Vault
    Monitoring -.-> Services
    Monitoring -.-> DB
```

### 7.2 Network Segmentation

**VPC Structure:**
- **Public Subnets**: Load balancers, NAT gateways
- **Private Subnets**: Application servers
- **Database Subnets**: Databases (no internet access)

**Security Groups:**
```yaml
# API Gateway Security Group
api-gateway-sg:
  inbound:
    - port: 443
      source: 0.0.0.0/0
      protocol: TCP
  outbound:
    - port: 8080
      destination: services-sg
      protocol: TCP

# Services Security Group
services-sg:
  inbound:
    - port: 8080
      source: api-gateway-sg
      protocol: TCP
  outbound:
    - port: 5432
      destination: database-sg
      protocol: TCP
    - port: 6379
      destination: redis-sg
      protocol: TCP

# Database Security Group
database-sg:
  inbound:
    - port: 5432
      source: services-sg
      protocol: TCP
  outbound: [] # No outbound
```

### 7.3 DDoS Protection

**Mitigation Strategies:**
1. **Rate Limiting**: Application-level (see API Security)
2. **CDN**: CloudFlare, AWS CloudFront
3. **WAF Rules**: Block malicious traffic
4. **Elastic Scaling**: Auto-scale on load
5. **Monitoring**: Real-time traffic analysis

**CloudFlare Configuration:**
- Challenge on suspicious requests
- Rate limit: 1000 req/min per IP
- Country blocking (if needed)
- Bot protection enabled

---

## 8. Application Security

### 8.1 Secure Development Lifecycle (SDL)

```mermaid
graph LR
    A[Requirements] --> B[Design]
    B --> C[Implementation]
    C --> D[Testing]
    D --> E[Deployment]
    E --> F[Maintenance]
    
    B -.Security Design Review.-> B
    C -.Secure Coding.-> C
    D -.Security Testing.-> D
    E -.Security Scanning.-> E
    F -.Incident Response.-> F
```

### 8.2 Code Security Standards

**Secure Coding Practices:**
1. **Input Validation**: Validate all inputs
2. **Output Encoding**: Encode all outputs
3. **Authentication**: Verify user identity
4. **Authorization**: Check permissions
5. **Error Handling**: Don't expose sensitive info
6. **Logging**: Log security events
7. **Cryptography**: Use strong algorithms

**Code Review Checklist:**
- [ ] Input validation implemented
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (output encoding)
- [ ] CSRF protection
- [ ] Authentication checks
- [ ] Authorization checks
- [ ] Secure password storage
- [ ] Sensitive data encryption
- [ ] Error handling without info leakage
- [ ] Security logging

### 8.3 Dependency Security

**Dependency Scanning:**
- **npm audit**: Node.js dependencies
- **cargo audit**: Rust dependencies
- **OWASP Dependency-Check**: Java dependencies
- **Snyk**: Continuous monitoring

**Update Policy:**
- Critical vulnerabilities: Patch within 24 hours
- High vulnerabilities: Patch within 7 days
- Medium vulnerabilities: Patch within 30 days
- Low vulnerabilities: Next release cycle

**Example (GitHub Actions):**
```yaml
name: Security Scan
on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Snyk
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      
      - name: Run Trivy
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          severity: 'HIGH,CRITICAL'
```

### 8.4 Container Security

**Docker Security:**
- **Base Images**: Use official, minimal images
- **User**: Run as non-root user
- **Scanning**: Trivy, Clair
- **Secrets**: Never in Dockerfile
- **Signing**: Sign images with Docker Content Trust

**Dockerfile Best Practices:**
```dockerfile
FROM rust:1.75-slim AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

# Final stage
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -u 1000 appuser
USER appuser

COPY --from=builder /app/target/release/app /usr/local/bin/app

EXPOSE 8080
CMD ["app"]
```

**Kubernetes Security:**
- **Pod Security Standards**: Restricted
- **Network Policies**: Limit pod-to-pod communication
- **RBAC**: Least privilege
- **Secrets**: External secrets operator (Vault)

---

## 9. Database Security

### 9.1 PostgreSQL Security

**Configuration:**
```conf
# Authentication
password_encryption = scram-sha-256
ssl = on
ssl_cert_file = '/path/to/cert.pem'
ssl_key_file = '/path/to/key.pem'

# Connections
listen_addresses = 'localhost'
max_connections = 100

# Logging
log_connections = on
log_disconnections = on
log_statement = 'ddl'
log_min_duration_statement = 1000
```

**Access Control:**
```sql
-- Create roles with minimal privileges
CREATE ROLE app_reader;
GRANT CONNECT ON DATABASE mary TO app_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_reader;

CREATE ROLE app_writer;
GRANT CONNECT ON DATABASE mary TO app_writer;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO app_writer;

-- Create application user
CREATE USER app_user WITH PASSWORD 'strong_password';
GRANT app_writer TO app_user;
```

**Row-Level Security (RLS):**
```sql
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;

CREATE POLICY user_contacts ON contacts
    FOR ALL
    TO app_user
    USING (user_id = current_setting('app.user_id')::uuid);
```

### 9.2 MongoDB Security

**Configuration:**
```yaml
security:
  authorization: enabled
  
net:
  tls:
    mode: requireTLS
    certificateKeyFile: /path/to/cert.pem
    CAFile: /path/to/ca.pem
```

**Access Control:**
```javascript
// Create roles
db.createRole({
  role: "readWriteApp",
  privileges: [
    { resource: { db: "mary", collection: "" }, actions: ["find", "insert", "update"] }
  ],
  roles: []
});

// Create user
db.createUser({
  user: "app_user",
  pwd: "strong_password",
  roles: ["readWriteApp"]
});
```

### 9.3 Redis Security

**Configuration:**
```conf
# Authentication
requirepass strong_password

# TLS
tls-port 6380
tls-cert-file /path/to/cert.pem
tls-key-file /path/to/key.pem
tls-ca-cert-file /path/to/ca.pem

# Disable dangerous commands
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command CONFIG ""
```

### 9.4 Backup Security

**Backup Strategy:**
- **Frequency**: Daily full, hourly incremental
- **Retention**: 30 days
- **Encryption**: AES-256
- **Storage**: Separate geographic location
- **Testing**: Monthly restore tests

**PostgreSQL Backup:**
```bash
#!/bin/bash
# Encrypted backup script
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="mary_backup_${BACKUP_DATE}.sql.gpg"

pg_dump -U postgres mary | \
  gpg --symmetric --cipher-algo AES256 --output ${BACKUP_FILE}

# Upload to S3 with server-side encryption
aws s3 cp ${BACKUP_FILE} s3://mary-backups/ --sse AES256
```

---

## 10. Infrastructure Security

### 10.1 Cloud Security (AWS)

**IAM Best Practices:**
- Least privilege principle
- MFA for all users
- Service-specific IAM roles
- Regular access reviews
- No root account usage

**Example IAM Policy:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::mary-uploads/*"
    }
  ]
}
```

**VPC Security:**
- Private subnets for databases
- NAT Gateway for outbound
- Security groups (stateful firewall)
- Network ACLs (stateless firewall)

### 10.2 Kubernetes Security

**Pod Security:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: app
    image: mary/app:latest
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
```

**Network Policies:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-policy
spec:
  podSelector:
    matchLabels:
      app: api-gateway
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 8080
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: backend
    ports:
    - protocol: TCP
      port: 8080
```

---

## 11. Third-Party Integration Security

### 11.1 AI Provider Security

**API Key Management:**
- Store in HashiCorp Vault
- Rotate every 90 days
- Separate keys per environment
- Monitor usage

**Data Privacy:**
- **Data Minimization**: Send only necessary data
- **Opt-In**: User consent for data sharing
- **Data Residency**: Choose region-appropriate providers
- **Retention**: Request deletion after processing

**Example (Secure API Call):**
```typescript
import axios from 'axios';
import { getSecret } from './vault';

async function callAIProvider(prompt: string) {
  const apiKey = await getSecret('openai_api_key');
  
  const response = await axios.post(
    'https://api.openai.com/v1/chat/completions',
    {
      model: 'gpt-4',
      messages: [{ role: 'user', content: sanitizeInput(prompt) }],
      // Don't store conversations
      user: hashUserId(userId), // Anonymized
    },
    {
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
      },
      timeout: 30000,
    }
  );
  
  return response.data;
}
```

### 11.2 Social Media Integration Security

**OAuth Token Security:**
- **Storage**: Encrypted in database
- **Scope**: Minimum required permissions
- **Expiration**: Refresh tokens regularly
- **Revocation**: Allow users to disconnect

**Webhook Validation:**
```typescript
import crypto from 'crypto';

function validateWebhook(
  payload: string,
  signature: string,
  secret: string
): boolean {
  const hmac = crypto.createHmac('sha256', secret);
  hmac.update(payload);
  const digest = hmac.digest('hex');
  
  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(digest)
  );
}
```

### 11.3 Email Service Security

**SPF, DKIM, DMARC:**
```dns
# SPF Record
mary.io. IN TXT "v=spf1 include:_spf.sendgrid.net ~all"

# DKIM Record
default._domainkey.mary.io. IN TXT "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA..."

# DMARC Record
_dmarc.mary.io. IN TXT "v=DMARC1; p=reject; rua=mailto:dmarc@mary.io"
```

---

## 12. Secrets Management

### 12.1 HashiCorp Vault

**Architecture:**
```mermaid
graph LR
    A[Application] -->|Auth| B[Vault]
    B -->|Dynamic Secret| A
    B --> C[(Encrypted Storage)]
    D[Admin] -->|Seal/Unseal| B
```

**Setup:**
```bash
# Initialize Vault
vault operator init

# Unseal Vault (requires 3 out of 5 keys)
vault operator unseal <key1>
vault operator unseal <key2>
vault operator unseal <key3>

# Enable secrets engine
vault secrets enable -path=mary kv-v2

# Store secret
vault kv put mary/database username=admin password=secret
```

**Application Integration (Rust):**
```rust
use vaultrs::client::{VaultClient, VaultClientSettingsBuilder};

pub async fn get_secret(key: &str) -> Result<String, Error> {
    let client = VaultClient::new(
        VaultClientSettingsBuilder::default()
            .address("https://vault.mary.io")
            .token(std::env::var("VAULT_TOKEN")?)
            .build()?,
    )?;
    
    let secret: std::collections::HashMap<String, String> = 
        client.kv2("mary", key).await?;
    
    Ok(secret.get("value").ok_or(Error::SecretNotFound)?.clone())
}
```

### 12.2 Environment Variables

**Best Practices:**
- Never commit to Git
- Use `.env.example` for templates
- Different secrets per environment
- Rotate regularly

**.env.example:**
```bash
# Database
DATABASE_URL=postgresql://user:pass@localhost/mary

# Redis
REDIS_URL=redis://localhost:6379

# API Keys
OPENAI_API_KEY=your_key_here
STRIPE_SECRET_KEY=your_key_here

# JWT
JWT_PRIVATE_KEY_PATH=/path/to/private.pem
JWT_PUBLIC_KEY_PATH=/path/to/public.pem
```

### 12.3 Certificate Management

**Let's Encrypt Automation:**
```bash
# Certbot with automatic renewal
certbot certonly --standalone -d api.mary.io --agree-tos --email admin@mary.io

# Cron job for renewal
0 0 * * * certbot renew --quiet && systemctl reload nginx
```

**Certificate Rotation:**
- Automatic renewal 30 days before expiry
- Certificate transparency monitoring
- Multi-domain support (SAN)

---

## 13. Security Monitoring & Incident Response

### 13.1 Security Monitoring

**What to Monitor:**
1. **Authentication Events**
   - Failed login attempts
   - MFA failures
   - Password changes
   - Account lockouts

2. **Authorization Events**
   - Permission denials
   - Privilege escalations
   - Access to sensitive resources

3. **Application Events**
   - Errors and exceptions
   - API rate limit hits
   - Invalid inputs
   - File uploads/downloads

4. **Infrastructure Events**
   - Unusual network traffic
   - Resource exhaustion
   - Configuration changes
   - Service crashes

**SIEM (Security Information and Event Management):**
- **Tool**: ELK Stack + Wazuh
- **Log Aggregation**: All services → Logstash → Elasticsearch
- **Alerting**: Kibana alerts → PagerDuty/Slack
- **Retention**: 1 year for security logs

**Alert Rules:**
```yaml
# Elasticsearch Watcher alert
{
  "trigger": {
    "schedule": { "interval": "5m" }
  },
  "input": {
    "search": {
      "request": {
        "indices": ["logs-*"],
        "body": {
          "query": {
            "bool": {
              "must": [
                { "match": { "event": "login_failed" }},
                { "range": { "@timestamp": { "gte": "now-5m" }}}
              ]
            }
          }
        }
      }
    }
  },
  "condition": {
    "compare": { "ctx.payload.hits.total": { "gt": 5 }}
  },
  "actions": {
    "notify_security": {
      "email": {
        "to": "security@mary.io",
        "subject": "Multiple failed login attempts detected",
        "body": "{{ctx.payload.hits.total}} failed login attempts in the last 5 minutes"
      }
    }
  }
}
```

### 13.2 Incident Response Plan

**Phase 1: Preparation**
- Incident response team identified
- Communication channels established
- Tools and access ready
- Runbooks documented

**Phase 2: Detection & Analysis**
1. Alert received
2. Triage and classify severity
3. Gather evidence
4. Determine scope

**Phase 3: Containment**
- **Short-term**: Isolate affected systems
- **Long-term**: Patch vulnerabilities

**Phase 4: Eradication**
- Remove malware/backdoors
- Close vulnerabilities
- Update access credentials

**Phase 5: Recovery**
- Restore from backups
- Verify system integrity
- Monitor for reinfection

**Phase 6: Lessons Learned**
- Post-incident review
- Update procedures
- Improve defenses

**Severity Levels:**

| Level | Description | Response Time | Notification |
|-------|-------------|---------------|--------------|
| **Critical** | Data breach, system compromise | < 1 hour | CEO, CISO, legal |
| **High** | Service outage, vulnerability | < 4 hours | CTO, security team |
| **Medium** | Degraded performance | < 24 hours | Operations team |
| **Low** | Minor issues | < 1 week | Log for review |

### 13.3 Security Metrics

**Key Performance Indicators (KPIs):**
- **Mean Time to Detect (MTTD)**: < 1 hour
- **Mean Time to Respond (MTTR)**: < 4 hours
- **False Positive Rate**: < 5%
- **Vulnerability Remediation Time**: < 48 hours (critical)
- **Security Test Coverage**: > 80%
- **Incidents per Month**: Track trend

---

## 14. Compliance & Auditing

### 14.1 Compliance Requirements

| Regulation | Applicability | Key Requirements |
|------------|---------------|------------------|
| **GDPR** | EU users | Consent, data portability, right to erasure |
| **CCPA** | California users | Data disclosure, opt-out, deletion |
| **PCI-DSS** | Payment processing | Secure payment data, compliance scans |
| **SOC 2** | Enterprise customers | Security, availability, confidentiality |
| **ISO 27001** | Information security | ISMS implementation |

### 14.2 Audit Logging

**What to Log:**
- Authentication/authorization events
- Data access (who, what, when)
- Configuration changes
- Administrative actions
- Security events

**Log Format (JSON):**
```json
{
  "timestamp": "2025-12-25T12:00:00Z",
  "event_type": "user_login",
  "user_id": "uuid",
  "ip_address": "192.168.1.1",
  "user_agent": "Mary Desktop/1.0.0",
  "result": "success",
  "mfa_used": true,
  "session_id": "uuid"
}
```

**Implementation (Rust):**
```rust
use serde_json::json;
use tracing::{info, instrument};

#[instrument]
pub async fn log_security_event(
    event_type: &str,
    user_id: &str,
    details: serde_json::Value,
) {
    let log_entry = json!({
        "timestamp": chrono::Utc::now().to_rfc3339(),
        "event_type": event_type,
        "user_id": user_id,
        "details": details,
    });
    
    info!(
        target: "security_audit",
        "{}",
        serde_json::to_string(&log_entry).unwrap()
    );
}
```

### 14.3 Regular Audits

**Audit Schedule:**
- **Security Audit**: Quarterly
- **Penetration Testing**: Biannually
- **Code Review**: Every release
- **Access Review**: Monthly
- **Compliance Audit**: Annually

**Audit Checklist:**
- [ ] Review user access privileges
- [ ] Check for inactive accounts
- [ ] Verify encryption status
- [ ] Review security logs
- [ ] Test backup restoration
- [ ] Scan for vulnerabilities
- [ ] Review API keys
- [ ] Check certificate expiry
- [ ] Review firewall rules
- [ ] Test incident response

---

## 15. Security Testing Strategy

### 15.1 Testing Levels

```mermaid
graph TD
    A[Security Testing] --> B[SAST]
    A --> C[DAST]
    A --> D[IAST]
    A --> E[Penetration Testing]
    A --> F[Vulnerability Scanning]
    
    B --> B1[SonarQube]
    B --> B2[Semgrep]
    
    C --> C1[OWASP ZAP]
    C --> C2[Burp Suite]
    
    E --> E1[Manual Testing]
    E --> E2[Automated Tools]
    
    F --> F1[Nessus]
    F --> F2[OpenVAS]
```

### 15.2 Static Analysis (SAST)

**Tools:**
- **SonarQube**: Code quality and security
- **Semgrep**: Pattern-based scanning
- **cargo-audit**: Rust dependencies
- **npm audit**: Node.js dependencies

**CI/CD Integration:**
```yaml
# GitHub Actions
name: SAST
on: [push, pull_request]

jobs:
  sonarqube:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: SonarQube Scan
        uses: sonarsource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
  
  semgrep:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: returntocorp/semgrep-action@v1
        with:
          config: >-
            p/security-audit
            p/secrets
            p/owasp-top-ten
```

### 15.3 Dynamic Analysis (DAST)

**OWASP ZAP Scan:**
```bash
#!/bin/bash
# ZAP baseline scan
docker run -t owasp/zap2docker-stable zap-baseline.py \
  -t https://staging.mary.io \
  -r zap-report.html
```

**Burp Suite Professional:**
- Automated scanning
- Manual testing
- Session handling
- Extension for custom checks

### 15.4 Penetration Testing

**Frequency**: Biannually

**Scope:**
- Desktop application
- Web APIs
- Database security
- Network security
- Social engineering

**Methodology**: OWASP Testing Guide

**Deliverables:**
- Executive summary
- Detailed findings
- Proof of concept
- Remediation recommendations

---

## 16. Security Training & Awareness

### 16.1 Developer Training

**Topics:**
- Secure coding practices
- OWASP Top 10
- Common vulnerabilities
- Security tools usage
- Incident response

**Frequency**: Quarterly

### 16.2 Security Champions

**Role**: Developers with security focus

**Responsibilities:**
- Promote security awareness
- Review code for security
- Stay updated on threats
- Assist in incident response

### 16.3 Phishing Awareness

**Simulated Phishing Campaigns:**
- Quarterly tests
- Track click-through rate
- Provide immediate training

---

## Summary

This security plan establishes a comprehensive security framework for the Mary platform:

1. **Multi-Layered Defense**: Security at every layer (network, application, data)
2. **Strong Authentication**: MFA, OAuth 2.0, JWT with RS256
3. **Data Protection**: AES-256 encryption, TLS 1.3, field-level encryption
4. **API Security**: Rate limiting, input validation, CSRF protection
5. **PCI-DSS Compliance**: Stripe tokenization, no card data storage
6. **Monitoring**: Real-time security monitoring, incident response
7. **Testing**: Comprehensive security testing strategy
8. **Compliance**: GDPR, CCPA, SOC 2 ready

**Security is not a one-time effort but an ongoing process.** This plan must be regularly reviewed and updated to address emerging threats.

**Next Steps:**
1. Review and approve this security plan
2. Implement security controls during development
3. Conduct security training for the team
4. Perform initial security audit
5. Establish security monitoring

---

**Document Version:** 1.0.0  
**Last Updated:** 2025-12-25  
**Author:** Security Architecture Team  
**Classification:** Confidential  
**Status:** Draft - Awaiting Approval