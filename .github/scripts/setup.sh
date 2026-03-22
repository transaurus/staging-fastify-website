#!/usr/bin/env bash
set -euo pipefail

# Setup script for fastify/website Docusaurus i18n
# Docusaurus 3.9.2, npm, Node >=22

REPO_URL="https://github.com/fastify/website.git"
BRANCH="main"

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

# ── Clone ─────────────────────────────────────────────────────────────────────
echo "Cloning $REPO_URL (branch: $BRANCH)..."
git clone --depth=1 --branch "$BRANCH" "$REPO_URL" source-repo

cd source-repo

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

# ── write-translations ───────────────────────────────────────────────────────
echo "Running write-translations..."
npx docusaurus write-translations

echo "SUCCESS: write-translations completed"
ls -la i18n/ 2>/dev/null || echo "No i18n dir found"

# ── build ─────────────────────────────────────────────────────────────────────
echo "Running npm run build..."
npm run build

echo "SUCCESS: build completed"
ls -la build/ 2>/dev/null || echo "No build dir found"
