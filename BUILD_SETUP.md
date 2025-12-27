# Mary Platform - Build Setup Documentation

## Overview

This document describes the TypeScript build system and development environment setup for the Mary Platform project. The project uses a monorepo structure with npm workspaces to manage multiple packages and services.

## Project Structure

```
Mary/
├── desktop/                    # Tauri + React desktop application
│   ├── src/                   # React source files
│   ├── src-tauri/             # Tauri Rust backend
│   ├── package.json           # Desktop app dependencies
│   ├── tsconfig.json          # TypeScript configuration
│   └── vite.config.ts         # Vite build configuration
├── services/
│   ├── mcp-server/            # MCP Server (TypeScript)
│   │   ├── package.json
│   │   └── tsconfig.json
│   └── websocket/             # WebSocket Service (TypeScript)
│       ├── package.json
│       └── tsconfig.json
├── shared/
│   └── types/                 # Shared TypeScript type definitions
│       ├── api/               # API-related types
│       ├── models/            # Data model types
│       ├── package.json
│       └── tsconfig.json
└── package.json               # Root monorepo configuration
```

## Dependencies Installed

### Root Level (560 packages)
- **TypeScript**: ^5.0.0 - Type-safe JavaScript
- **ESLint**: ^8.0.0 - Code linting
- **Prettier**: ^3.0.0 - Code formatting
- **Concurrently**: ^8.0.0 - Run multiple commands
- **@typescript-eslint/eslint-plugin**: ^6.0.0
- **@typescript-eslint/parser**: ^6.0.0

### Desktop App
- **React**: ^18.2.0 - UI library
- **React DOM**: ^18.2.0
- **React Router**: ^6.20.0 - Routing
- **Vite**: ^5.0.8 - Build tool and dev server
- **Tauri CLI**: ^1.5.0 - Desktop app framework
- **TailwindCSS**: ^3.4.0 - CSS framework
- **Zustand**: ^4.4.7 - State management
- **@tanstack/react-query**: ^5.14.0 - Data fetching
- **Axios**: ^1.6.2 - HTTP client
- **Zod**: ^3.22.4 - Schema validation

### Services
**MCP Server & WebSocket Service:**
- **Express**: ^4.18.2 - Web framework
- **TypeScript**: ^5.3.3
- **tsx**: ^4.7.0 - TypeScript execution
- **Redis**: ^4.6.12 - Cache and pub/sub
- **dotenv**: ^16.3.1 - Environment variables

### Shared Packages
**@mary/types:**
- **TypeScript**: ^5.3.3 - Type definitions only

## Available NPM Scripts

### Development Scripts

```bash
# Start desktop app in development mode
npm run dev:desktop

# Start MCP server in development mode
npm run dev:mcp

# Start WebSocket service in development mode
npm run dev:websocket

# Start desktop app and services together
npm run dev
```

### Build Scripts

```bash
# Build everything (types, desktop, services)
npm run build:all

# Build only shared types
npm run build:types

# Build only desktop app
npm run build:desktop

# Build only MCP server
npm run build:mcp

# Build only WebSocket service
npm run build:websocket

# Build all TypeScript services (mcp + websocket)
npm run build:services

# Build types, desktop, and services (default build)
npm run build
```

### Type Checking Scripts

```bash
# Type check all TypeScript code
npm run typecheck

# Type check desktop app only
npm run typecheck:desktop

# Type check all services
npm run typecheck:services

# Type check MCP server
npm run typecheck:mcp

# Type check WebSocket service
npm run typecheck:websocket

# Type check shared types
npm run typecheck:types
```

### Installation Scripts

```bash
# Install root dependencies
npm install

# Install all workspace dependencies
npm run install:all

# Install only workspace packages
npm run install:workspaces
```

### Code Quality Scripts

```bash
# Run ESLint on all code
npm run lint

# Format all code with Prettier
npm run format

# Run unit tests
npm run test:unit

# Run integration tests
npm run test:integration

# Run end-to-end tests
npm run test:e2e

# Run all tests
npm run test
```

## Monorepo Workspace Configuration

The project uses npm workspaces defined in the root [`package.json`](package.json:6):

```json
"workspaces": [
  "desktop",
  "services/mcp-server",
  "services/websocket",
  "shared/types",
  "shared/utils"
]
```

This configuration allows:
- **Shared node_modules**: All packages share dependencies
- **Workspace linking**: Packages can reference each other
- **Parallel installs**: npm installs all workspace dependencies together
- **Hoisting**: Common dependencies are hoisted to root

## TypeScript Configuration

### Shared Types ([`shared/types/tsconfig.json`](shared/types/tsconfig.json))

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "declaration": true,
    "declarationMap": true,
    "outDir": "./dist",
    "composite": true,
    "strict": true,
    "esModuleInterop": true,
    "moduleResolution": "node"
  }
}
```

### Desktop App ([`desktop/tsconfig.json`](desktop/tsconfig.json))

Configured for React with path aliases:
- `@/`: Maps to `./src`
- `@/features`: Maps to `./src/features`
- `@/components`: Maps to `./src/shared/components`
- `@/hooks`: Maps to `./src/shared/hooks`
- `@/types`: Maps to `./src/shared/types`

### Services Configuration

Both MCP server and WebSocket service use similar TypeScript configurations:
- **Target**: ES2020
- **Module**: ESNext
- **Type checking**: Strict mode enabled
- **Output**: Compiled to `dist/` directory

## Development Workflow

### Initial Setup

1. **Clone the repository** (already done):
   ```bash
   cd C:\Martin\WEB\Mary
   ```

2. **Install all dependencies**:
   ```bash
   npm run install:all
   ```

3. **Build shared types** (required before other packages):
   ```bash
   npm run build:types
   ```

### Daily Development

1. **Start the desktop app**:
   ```bash
   npm run dev:desktop
   ```
   This starts Vite dev server on port 3000

2. **Start services in separate terminals**:
   ```bash
   # Terminal 2
   npm run dev:mcp
   
   # Terminal 3
   npm run dev:websocket
   ```

3. **Or start everything together**:
   ```bash
   npm run dev
   ```

### Before Committing

1. **Type check all code**:
   ```bash
   npm run typecheck
   ```

2. **Lint code**:
   ```bash
   npm run lint
   ```

3. **Format code**:
   ```bash
   npm run format
   ```

4. **Run tests**:
   ```bash
   npm run test
   ```

### Building for Production

1. **Build everything**:
   ```bash
   npm run build:all
   ```

2. **Or build selectively**:
   ```bash
   npm run build:types
   npm run build:desktop
   npm run build:services
   ```

## Build Output Locations

- **Shared Types**: `shared/types/dist/`
- **Desktop App**: `desktop/dist/`
- **MCP Server**: `services/mcp-server/dist/`
- **WebSocket Service**: `services/websocket/dist/`

## Vite Configuration

The desktop app uses Vite with the following features:
- **React plugin**: Fast refresh and JSX support
- **Port**: Fixed at 3000 for Tauri compatibility
- **Path aliases**: Simplified imports
- **Tauri integration**: Optimized for desktop app
- **TailwindCSS**: Integrated via PostCSS

See [`desktop/vite.config.ts`](desktop/vite.config.ts) for full configuration.

## Environment Configuration

### Desktop App

Create [`desktop/.env`](desktop/.env) for environment variables:
```env
VITE_API_URL=http://localhost:8000
VITE_WS_URL=ws://localhost:8001
```

### Services

Create service-specific `.env` files:

**services/mcp-server/.env:**
```env
PORT=8000
REDIS_URL=redis://localhost:6379
NODE_ENV=development
```

**services/websocket/.env:**
```env
PORT=8001
REDIS_URL=redis://localhost:6379
NODE_ENV=development
```

## Troubleshooting

### Issue: npm install fails with workspace errors

**Solution**: Ensure all workspace packages have valid `package.json` files. Run:
```bash
npm install --legacy-peer-deps
```

### Issue: TypeScript compilation errors in services

**Solution**: Build shared types first:
```bash
npm run build:types
```

### Issue: Vite dev server won't start

**Solution**: 
1. Check if port 3000 is already in use
2. Kill any existing processes on port 3000
3. Clear Vite cache: `rm -rf desktop/node_modules/.vite`

### Issue: Import errors with @mary/types

**Solution**: 
1. Rebuild shared types: `npm run build:types`
2. Restart TypeScript server in VS Code: Ctrl+Shift+P → "TypeScript: Restart TS Server"

### Issue: Module resolution errors

**Solution**: Check that path aliases in `tsconfig.json` match the actual directory structure.

## Security Notes

Current setup has **6 moderate and 1 high severity vulnerabilities** from npm dependencies. To address:

```bash
# Review vulnerabilities
npm audit

# Auto-fix non-breaking issues
npm audit fix

# Fix all including breaking changes (use with caution)
npm audit fix --force
```

**Note**: Always test after running `npm audit fix --force` as it may introduce breaking changes.

## Next Steps

### Immediate Actions

1. **Set up environment files**: Create `.env` files for all services
2. **Configure Rust environment**: Install Rust and Tauri prerequisites for desktop app
3. **Start development**: Run `npm run dev` to begin development

### Recommended Enhancements

1. **Add pre-commit hooks**: Use Husky to run linting and type checking before commits
2. **Set up CI/CD**: Configure GitHub Actions for automated testing and building
3. **Add test coverage**: Implement comprehensive test suites for all packages
4. **Docker support**: Complete Docker configuration for services
5. **Documentation**: Add JSDoc comments to key functions and types

### Testing Strategy

1. **Unit tests**: Test individual components and functions
2. **Integration tests**: Test service interactions
3. **E2E tests**: Test complete user workflows
4. **Type tests**: Verify type safety across packages

## Additional Resources

- [Vite Documentation](https://vitejs.dev/)
- [Tauri Documentation](https://tauri.app/)
- [npm Workspaces](https://docs.npmjs.com/cli/v8/using-npm/workspaces)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [React Documentation](https://react.dev/)

## Summary

✅ **Installed**: 560+ packages across root and workspaces
✅ **Configured**: TypeScript build system with monorepo support
✅ **Verified**: Successful compilation and builds
✅ **Scripts**: Comprehensive npm scripts for development and production
✅ **Repository**: Synchronized with GitHub at https://github.com/kuprik23/marymagalene

The Mary Platform development environment is now fully configured and ready for development!

---

**Last Updated**: 2025-12-26
**Maintainer**: Mary Platform Team
**Repository**: https://github.com/kuprik23/marymagalene