# Mary Platform - Directory Structure Setup Script
# This script creates all necessary directories for the project

Write-Host "Creating Mary Platform directory structure..." -ForegroundColor Green

$baseDir = "C:\Martin\WEB\Mary"
Set-Location $baseDir

# Main directories
$mainDirs = @(
    "desktop",
    "services",
    "native",
    "shared",
    "infrastructure",
    "docs",
    "scripts",
    "tests"
)

# Desktop app directories
$desktopDirs = @(
    "desktop/src/features/auth/components",
    "desktop/src/features/auth/hooks",
    "desktop/src/features/auth/services",
    "desktop/src/features/auth/store",
    "desktop/src/features/auth/types",
    "desktop/src/features/ai-orchestrator/components",
    "desktop/src/features/ai-orchestrator/hooks",
    "desktop/src/features/ai-orchestrator/services",
    "desktop/src/features/ai-orchestrator/store",
    "desktop/src/features/ai-orchestrator/types",
    "desktop/src/features/crm/components",
    "desktop/src/features/crm/hooks",
    "desktop/src/features/crm/services",
    "desktop/src/features/crm/store",
    "desktop/src/features/crm/types",
    "desktop/src/features/social-media/components",
    "desktop/src/features/social-media/hooks",
    "desktop/src/features/social-media/services",
    "desktop/src/features/social-media/types",
    "desktop/src/features/api-manager/components",
    "desktop/src/features/api-manager/hooks",
    "desktop/src/features/api-manager/services",
    "desktop/src/features/api-manager/types",
    "desktop/src/features/app-integration/components",
    "desktop/src/features/app-integration/hooks",
    "desktop/src/features/app-integration/services",
    "desktop/src/features/app-integration/types",
    "desktop/src/features/client-portal/components",
    "desktop/src/features/client-portal/hooks",
    "desktop/src/features/client-portal/services",
    "desktop/src/features/client-portal/types",
    "desktop/src/features/payments/components",
    "desktop/src/features/payments/hooks",
    "desktop/src/features/payments/services",
    "desktop/src/features/payments/types",
    "desktop/src/features/admin/components",
    "desktop/src/features/admin/hooks",
    "desktop/src/features/admin/services",
    "desktop/src/features/admin/types",
    "desktop/src/shared/components/ui",
    "desktop/src/shared/components/layout",
    "desktop/src/shared/components/common",
    "desktop/src/shared/hooks",
    "desktop/src/shared/utils",
    "desktop/src/shared/types",
    "desktop/src/shared/constants",
    "desktop/src/store",
    "desktop/src/services/api",
    "desktop/src/services/websocket",
    "desktop/src/layouts",
    "desktop/src/routes",
    "desktop/src/styles/themes",
    "desktop/src/assets/images",
    "desktop/src/assets/icons",
    "desktop/src/assets/fonts",
    "desktop/src-tauri/src/commands",
    "desktop/src-tauri/src/security",
    "desktop/src-tauri/src/system",
    "desktop/src-tauri/src/storage",
    "desktop/src-tauri/src/integration",
    "desktop/src-tauri/src/utils",
    "desktop/public/icons",
    "desktop/tests/unit",
    "desktop/tests/integration",
    "desktop/tests/e2e"
)

# Services directories
$servicesDirs = @(
    "services/gateway/src/routes",
    "services/gateway/src/middleware",
    "services/gateway/src/proxy",
    "services/gateway/src/security",
    "services/gateway/src/config",
    "services/gateway/src/utils",
    "services/gateway/tests/integration",
    "services/gateway/tests/unit",
    "services/auth/src/routes",
    "services/auth/src/models",
    "services/auth/src/services",
    "services/auth/src/database",
    "services/auth/src/security",
    "services/auth/src/cache",
    "services/auth/src/config",
    "services/auth/src/utils",
    "services/auth/migrations",
    "services/auth/tests",
    "services/crm/src/main/java/com/mary/crm/controller",
    "services/crm/src/main/java/com/mary/crm/service",
    "services/crm/src/main/java/com/mary/crm/repository",
    "services/crm/src/main/java/com/mary/crm/model",
    "services/crm/src/main/java/com/mary/crm/dto",
    "services/crm/src/main/java/com/mary/crm/security",
    "services/crm/src/main/java/com/mary/crm/config",
    "services/crm/src/main/java/com/mary/crm/exception",
    "services/crm/src/main/resources/db/migration",
    "services/crm/src/test/java/com/mary/crm/controller",
    "services/crm/src/test/java/com/mary/crm/service",
    "services/crm/src/test/java/com/mary/crm/repository",
    "services/crm/gradle",
    "services/ai-orchestrator/src/main/java/com/mary/ai/controller",
    "services/ai-orchestrator/src/main/java/com/mary/ai/service",
    "services/ai-orchestrator/src/main/java/com/mary/ai/provider",
    "services/ai-orchestrator/src/main/java/com/mary/ai/repository",
    "services/ai-orchestrator/src/main/java/com/mary/ai/model",
    "services/ai-orchestrator/src/main/java/com/mary/ai/dto",
    "services/ai-orchestrator/src/main/java/com/mary/ai/config",
    "services/ai-orchestrator/src/main/java/com/mary/ai/vector",
    "services/ai-orchestrator/src/main/resources/db/migration",
    "services/ai-orchestrator/src/test",
    "services/integration-hub/src/main/kotlin/com/mary/integration/routes",
    "services/integration-hub/src/main/kotlin/com/mary/integration/services",
    "services/integration-hub/src/main/kotlin/com/mary/integration/models",
    "services/integration-hub/src/main/kotlin/com/mary/integration/repositories",
    "services/integration-hub/src/main/kotlin/com/mary/integration/oauth",
    "services/integration-hub/src/main/kotlin/com/mary/integration/config",
    "services/integration-hub/src/main/kotlin/com/mary/integration/plugins",
    "services/integration-hub/src/main/resources",
    "services/integration-hub/src/test",
    "services/payment/src/routes",
    "services/payment/src/services",
    "services/payment/src/models",
    "services/payment/src/database",
    "services/payment/src/security",
    "services/payment/src/config",
    "services/payment/migrations",
    "services/payment/tests",
    "services/mcp-server/src/server",
    "services/mcp-server/src/tools",
    "services/mcp-server/src/resources",
    "services/mcp-server/src/prompts",
    "services/mcp-server/src/context",
    "services/mcp-server/src/config",
    "services/mcp-server/src/types",
    "services/mcp-server/tests/unit",
    "services/mcp-server/tests/integration",
    "services/analytics/src/main/java/com/mary/analytics/controller",
    "services/analytics/src/main/java/com/mary/analytics/service",
    "services/analytics/src/main/java/com/mary/analytics/repository",
    "services/analytics/src/main/java/com/mary/analytics/model",
    "services/analytics/src/main/resources",
    "services/analytics/src/test",
    "services/websocket/src/server",
    "services/websocket/src/handlers",
    "services/websocket/src/auth",
    "services/websocket/src/types"
)

# Native modules directories
$nativeDirs = @(
    "native/filesystem/src",
    "native/filesystem/tests",
    "native/image-processor/src",
    "native/image-processor/tests",
    "native/video-transcoder/src",
    "native/video-transcoder/tests",
    "native/crypto-accelerator/src",
    "native/crypto-accelerator/tests",
    "native/shared/include",
    "native/shared/src"
)

# Shared directories
$sharedDirs = @(
    "shared/types/api",
    "shared/types/models",
    "shared/protos",
    "shared/schemas/postgresql",
    "shared/schemas/mongodb",
    "shared/schemas/redis",
    "shared/config",
    "shared/utils/typescript",
    "shared/utils/rust",
    "shared/utils/java"
)

# Infrastructure directories
$infraDirs = @(
    "infrastructure/docker/desktop",
    "infrastructure/docker/gateway",
    "infrastructure/docker/auth",
    "infrastructure/docker/crm",
    "infrastructure/docker/ai-orchestrator",
    "infrastructure/docker/integration-hub",
    "infrastructure/docker/payment",
    "infrastructure/docker/mcp-server",
    "infrastructure/kubernetes/namespaces",
    "infrastructure/kubernetes/deployments",
    "infrastructure/kubernetes/services",
    "infrastructure/kubernetes/ingress",
    "infrastructure/kubernetes/configmaps",
    "infrastructure/kubernetes/secrets",
    "infrastructure/kubernetes/persistent-volumes",
    "infrastructure/kubernetes/autoscaling",
    "infrastructure/terraform/aws",
    "infrastructure/terraform/azure",
    "infrastructure/terraform/gcp",
    "infrastructure/terraform/modules/database",
    "infrastructure/terraform/modules/compute",
    "infrastructure/terraform/modules/networking",
    "infrastructure/monitoring/prometheus",
    "infrastructure/monitoring/grafana/dashboards",
    "infrastructure/monitoring/elk",
    "infrastructure/monitoring/sentry",
    "infrastructure/scripts"
)

# Documentation directories
$docsDirs = @(
    "docs/api/openapi",
    "docs/api/postman",
    "docs/user-guides",
    "docs/developer",
    "docs/architecture/diagrams",
    "docs/architecture/decisions"
)

# Testing directories
$testsDirs = @(
    "tests/e2e/desktop",
    "tests/integration/api",
    "tests/integration/services",
    "tests/performance/load-tests",
    "tests/performance/stress-tests",
    "tests/security/penetration",
    "tests/security/vulnerability-scan"
)

# GitHub workflows
$githubDirs = @(
    ".github/workflows"
)

# Combine all directories
$allDirs = $mainDirs + $desktopDirs + $servicesDirs + $nativeDirs + $sharedDirs + $infraDirs + $docsDirs + $testsDirs + $githubDirs

# Create directories
$count = 0
foreach ($dir in $allDirs) {
    $fullPath = Join-Path $baseDir $dir
    if (-not (Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        $count++
    }
}

Write-Host "Created $count directories" -ForegroundColor Cyan
Write-Host "Directory structure setup complete!" -ForegroundColor Green