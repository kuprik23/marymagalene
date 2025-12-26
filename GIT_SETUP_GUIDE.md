# Git & VS Code Setup Guide

This guide will help you initialize Git, connect to GitHub, and open the project in Visual Studio Code.

---

## 📦 Project Location

```
C:\Martin\WEB\Mary
```

---

## 🚀 Quick Setup (3 Steps)

### Step 1: Open in Visual Studio Code

```powershell
# Open VS Code in the project directory
cd C:\Martin\WEB\Mary
code .
```

Or manually:
1. Open Visual Studio Code
2. File → Open Folder
3. Navigate to `C:\Martin\WEB\Mary`
4. Click "Select Folder"

### Step 2: Initialize Git Repository

In VS Code's integrated terminal (`` Ctrl+` ``), run:

```bash
git init
git add .
git commit -m "Initial commit: Mary Platform project structure

- 210+ directories created
- Root configuration files
- Desktop app (Tauri + React)
- 9 backend microservices
- 4 native C++ modules
- Infrastructure and documentation"
```

### Step 3: Connect to GitHub

#### Option A: Create new repository on GitHub (Recommended)

1. Go to https://github.com/new
2. Repository name: `mary-platform`
3. Description: `Multi-technology desktop application platform`
4. Choose Public or Private
5. **DO NOT** initialize with README, .gitignore, or license (we already have them)
6. Click "Create repository"

7. Connect your local repo:
```bash
git remote add origin https://github.com/YOUR_USERNAME/mary-platform.git
git branch -M main
git push -u origin main
```

#### Option B: Use GitHub CLI (if installed)

```bash
gh repo create mary-platform --private --source=. --remote=origin --push
```

---

## 📋 Detailed Instructions

### Initialize Git Repository

```bash
cd C:\Martin\WEB\Mary

# Initialize Git
git init

# Check status
git status

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Project structure setup"
```

### Create .gitattributes (Optional but Recommended)

This ensures consistent line endings across different operating systems:

```bash
# Create .gitattributes file
echo "* text=auto" > .gitattributes
echo "*.sh text eol=lf" >> .gitattributes
git add .gitattributes
git commit -m "Add .gitattributes for consistent line endings"
```

### Set Up GitHub Remote

1. **Create GitHub Repository:**
   - Go to https://github.com/new
   - Name: `mary-platform`
   - Keep it private for now (you can make it public later)
   - Don't add README, .gitignore, or license

2. **Add Remote and Push:**
```bash
# Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/mary-platform.git

# Verify remote
git remote -v

# Push to GitHub
git branch -M main
git push -u origin main
```

### Configure Git User (if not already done)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## 🔧 VS Code Extensions (Recommended)

Install these extensions for better development experience:

### Essential Extensions:
1. **Rust Analyzer** (`rust-lang.rust-analyzer`)
2. **Extension Pack for Java** (`vscjava.vscode-java-pack`)
3. **Kotlin** (`fwcd.kotlin`)
4. **ESLint** (`dbaeumer.vscode-eslint`)
5. **Prettier** (`esbenp.prettier-vscode`)
6. **Tauri** (`tauri-apps.tauri-vscode`)

### Additional Recommended:
7. **GitLens** (`eamodio.gitlens`) - Git supercharged
8. **Docker** (`ms-azuretools.vscode-docker`)
9. **Thunder Client** (`rangav.vscode-thunder-client`) - API testing
10. **Path Intellisense** (`christian-kohler.path-intellisense`)
11. **Error Lens** (`usernamehw.errorlens`)
12. **TODO Highlight** (`wayou.vscode-todo-highlight`)

### Install extensions via command line:
```bash
code --install-extension rust-lang.rust-analyzer
code --install-extension vscjava.vscode-java-pack
code --install-extension fwcd.kotlin
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension tauri-apps.tauri-vscode
code --install-extension eamodio.gitlens
```

---

## 📁 VS Code Workspace Settings

Create `.vscode/settings.json` for project-specific settings:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer"
  },
  "[java]": {
    "editor.defaultFormatter": "redhat.java"
  },
  "files.exclude": {
    "**/node_modules": true,
    "**/target": true,
    "**/dist": true,
    "**/.gradle": true
  },
  "typescript.tsdk": "node_modules/typescript/lib"
}
```

---

## 🌿 Git Workflow

### Daily Development:

```bash
# Check current status
git status

# Create a new feature branch
git checkout -b feature/your-feature-name

# Make changes...

# Stage changes
git add .

# Commit with descriptive message
git commit -m "feat: add user authentication"

# Push to GitHub
git push origin feature/your-feature-name
```

### Commit Message Convention:

Use conventional commits:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

---

## 🔄 Syncing with GitHub

### Push changes:
```bash
git push origin main
```

### Pull latest changes:
```bash
git pull origin main
```

### Create and switch branches:
```bash
# Create and switch to new branch
git checkout -b feature/new-feature

# Push branch to GitHub
git push -u origin feature/new-feature
```

---

## 📊 Verify Setup

After setup, verify everything works:

1. **Open in VS Code:**
   ```bash
   cd C:\Martin\WEB\Mary
   code .
   ```

2. **Check Git status:**
   ```bash
   git status
   ```

3. **Verify remote:**
   ```bash
   git remote -v
   ```

4. **View project structure:**
   Press `Ctrl+Shift+E` in VS Code to see the Explorer

5. **Open integrated terminal:**
   Press `` Ctrl+` ``

---

## 🎯 Next Steps After Git Setup

1. **Install Dependencies:**
   ```bash
   npm install
   cd desktop && npm install
   cd services/mcp-server && npm install
   cd services/websocket && npm install
   ```

2. **Set up environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

3. **Start development:**
   ```bash
   docker-compose up -d
   make dev
   ```

---

## 🆘 Troubleshooting

### Issue: Git not recognized
**Solution:** Install Git from https://git-scm.com/

### Issue: GitHub authentication failed
**Solution:** 
- Use Personal Access Token instead of password
- Or set up SSH keys: https://docs.github.com/en/authentication

### Issue: VS Code not opening
**Solution:** Make sure VS Code is added to PATH during installation

### Issue: Cannot push to GitHub
**Solution:**
```bash
# Check remote URL
git remote -v

# Update remote URL if needed
git remote set-url origin https://github.com/YOUR_USERNAME/mary-platform.git
```

---

## 📚 Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Docs](https://docs.github.com/)
- [VS Code Documentation](https://code.visualstudio.com/docs)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

---

## ✅ Setup Checklist

- [ ] Opened project in VS Code
- [ ] Initialized Git repository
- [ ] Created initial commit
- [ ] Created GitHub repository
- [ ] Connected local repo to GitHub
- [ ] Pushed to GitHub
- [ ] Installed recommended VS Code extensions
- [ ] Configured Git user settings
- [ ] Verified remote connection

---

**Ready to start developing!** 🚀

For project documentation, see:
- `README.md` - Project overview
- `ARCHITECTURE.md` - System architecture
- `PROJECT_STRUCTURE.md` - Detailed structure
- `SECURITY_PLAN.md` - Security requirements
- `SETUP_COMPLETE.md` - Setup summary