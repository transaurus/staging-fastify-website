#!/usr/bin/env bash
set -euo pipefail

# prepare.sh for fastify/website
# Clones repo, installs deps, generates required stubs.
# Does NOT run write-translations or build.

REPO_URL="https://github.com/fastify/website.git"
BRANCH="main"
REPO_DIR="source-repo"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Node 22 ───────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh"
  if ! nvm ls 22 2>/dev/null | grep -q "v22"; then
    echo "Installing Node 22..."
    nvm install 22
  fi
  nvm use 22
else
  echo "nvm not found at $NVM_DIR, trying system node..."
fi

echo "Node version: $(node --version)"
echo "npm version: $(npm --version)"

# ── Clone (skip if already exists) ───────────────────────────────────────────
if [ ! -d "$REPO_DIR" ]; then
  echo "Cloning $REPO_URL (branch: $BRANCH)..."
  git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$REPO_DIR"
else
  echo "Source repo already exists, skipping clone."
fi

cd "$REPO_DIR"

# ── Install main dependencies ─────────────────────────────────────────────────
echo "Installing main dependencies..."
npm install --ignore-scripts

# ── Generate required static data files ──────────────────────────────────────
echo "Installing scripts dependencies..."
npm --prefix ./scripts install

echo "Creating static/generated directory..."
mkdir -p static/generated

echo "Generating static data from YAML files..."
node ./scripts/build-static-data.js

echo "Creating stub files for plugins and benchmarks..."
# plugins.json must be { corePlugins: [...], communityPlugins: [...] } — not []
echo '{"corePlugins":[],"communityPlugins":[]}' > static/generated/plugins.json
# benchmarks.json must be { date, reference, frameworks: [...] } — not []
echo '{"date":"2024-01-01","reference":1,"frameworks":[]}' > static/generated/benchmarks.json

# ── Create versions.json ───────────────────────────────────────────────────────
# The config uses lastVersion: 'latest', so versions.json must have "latest" as a named version.
# With 2 entries, getVersionLabels sets v5.2.x as the "previous" version.
echo "Creating versions.json..."
echo '["latest", "v5.2.x"]' > versions.json

# ── Create versions-shipped.json ─────────────────────────────────────────────
# Used for redirect generation; minimal stub with recent versions
echo "Creating versions-shipped.json..."
echo '["5.8.2", "5.8.1", "5.8.0", "5.7.4", "5.7.3", "4.3.0", "3.29.0", "2.15.0", "1.14.0"]' > versions-shipped.json

# ── Create versioned docs stubs ───────────────────────────────────────────────
# Docusaurus needs versioned_docs directories to exist for versions in versions.json
echo "Creating versioned docs stubs..."
mkdir -p versioned_docs/version-latest
mkdir -p versioned_docs/version-v5.2.x

# Minimal markdown page for each version
cat > versioned_docs/version-latest/index.md << 'MDEOF'
---
id: index
title: Fastify
---
# Fastify
MDEOF

cat > versioned_docs/version-v5.2.x/index.md << 'MDEOF'
---
id: index
title: Fastify v5.2.x
---
# Fastify v5.2.x
MDEOF

# ── Create versioned sidebars ─────────────────────────────────────────────────
mkdir -p versioned_sidebars
echo '{}' > versioned_sidebars/version-latest-sidebars.json
echo '{}' > versioned_sidebars/version-v5.2.x-sidebars.json

# ── Apply fixes.json if present ───────────────────────────────────────────────
FIXES_JSON="$SCRIPT_DIR/fixes.json"
if [ -f "$FIXES_JSON" ]; then
  echo "[INFO] Applying content fixes..."
  node -e "
  const fs = require('fs');
  const path = require('path');
  const fixes = JSON.parse(fs.readFileSync('$FIXES_JSON', 'utf8'));
  for (const [file, ops] of Object.entries(fixes.fixes || {})) {
    if (!fs.existsSync(file)) { console.log('  skip (not found):', file); continue; }
    let content = fs.readFileSync(file, 'utf8');
    for (const op of ops) {
      if (op.type === 'replace' && content.includes(op.find)) {
        content = content.split(op.find).join(op.replace || '');
        console.log('  fixed:', file, '-', op.comment || '');
      }
    }
    fs.writeFileSync(file, content);
  }
  for (const [file, cfg] of Object.entries(fixes.newFiles || {})) {
    const c = typeof cfg === 'string' ? cfg : cfg.content;
    fs.mkdirSync(path.dirname(file), {recursive: true});
    fs.writeFileSync(file, c);
    console.log('  created:', file);
  }
  "
fi

echo "[DONE] Repository is ready for docusaurus commands."
