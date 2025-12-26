# Mary Desktop Application

> Cross-platform desktop application built with Tauri, React, and TypeScript

## Overview

The Mary desktop application provides a native, high-performance interface for the Mary platform, combining the power of Rust for the backend with React for the frontend.

## Technology Stack

### Frontend
- **React 18** - UI library
- **TypeScript** - Type-safe JavaScript
- **Vite** - Fast build tool
- **TailwindCSS** - Utility-first CSS
- **Zustand** - State management
- **React Query** - Server state management
- **React Router** - Routing

### Backend
- **Tauri** - Desktop application framework
- **Rust** - Systems programming language
- **SQLite** - Local database
- **Tokio** - Async runtime

## Project Structure

```
desktop/
├── src/                      # React frontend
│   ├── features/            # Feature-based modules
│   │   ├── auth/           # Authentication
│   │   ├── ai-orchestrator/# AI management
│   │   ├── crm/            # CRM features
│   │   ├── social-media/   # Social media
│   │   └── ...
│   ├── shared/             # Shared components
│   │   ├── components/     # UI components
│   │   ├── hooks/          # Custom hooks
│   │   ├── utils/          # Utilities
│   │   └── types/          # Type definitions
│   ├── services/           # API services
│   ├── store/              # Global state
│   └── App.tsx             # Root component
├── src-tauri/              # Rust backend
│   ├── src/
│   │   ├── commands/       # Tauri commands
│   │   ├── security/       # Security modules
│   │   ├── system/         # System integration
│   │   └── main.rs         # Entry point
│   └── Cargo.toml
└── public/                 # Static assets
```

## Getting Started

### Prerequisites

- Node.js >= 18.0.0
- Rust >= 1.70.0
- npm or yarn

### Installation

1. Install dependencies:
```bash
npm install
```

2. Start development server:
```bash
npm run tauri:dev
```

### Building

Build for production:
```bash
npm run tauri:build
```

This will create installers in `src-tauri/target/release/bundle/`

## Available Scripts

- `npm run dev` - Start Vite dev server
- `npm run tauri:dev` - Start Tauri in development mode
- `npm run build` - Build frontend
- `npm run tauri:build` - Build complete application
- `npm run lint` - Lint code
- `npm run format` - Format code
- `npm test` - Run tests

## Features

### Authentication
- Secure login/registration
- Multi-factor authentication
- Session management
- OAuth2 integration

### AI Orchestrator
- Multiple AI provider support
- Agent management
- Conversation history
- Prompt templates

### CRM
- Contact management
- Deal pipeline
- Activity tracking
- Custom fields

### Social Media
- Multi-platform posting
- Schedule management
- Analytics dashboard

### API Manager
- Universal API connector
- OAuth flows
- Webhook management

## Development

### Code Style

- Follow ESLint and Prettier configurations
- Use TypeScript for type safety
- Write tests for new features
- Follow feature-based architecture

### State Management

- Use Zustand for client state
- Use React Query for server state
- Keep state as local as possible

### API Integration

All API calls go through the API Gateway:
```typescript
import { apiClient } from '@/services/api/client';

const response = await apiClient.get('/endpoint');
```

## Security

- All sensitive data encrypted at rest
- Secure IPC communication between frontend and backend
- Regular security updates
- CSP headers configured

## Testing

```bash
# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Coverage
npm run test:coverage
```

## Troubleshooting

### Common Issues

1. **Tauri build fails**
   - Ensure Rust toolchain is installed
   - Check Cargo.toml dependencies

2. **Development server won't start**
   - Check if port 3000 is available
   - Clear node_modules and reinstall

3. **Type errors**
   - Run `npm run type-check`
   - Check tsconfig.json configuration

## Contributing

See [CONTRIBUTING.md](../docs/developer/contributing.md)

## License

MIT License - see [LICENSE](../LICENSE)