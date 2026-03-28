#!/usr/bin/env bash
set -euo pipefail

# rebuild.sh for fastify/website
# Runs on an existing source tree (no clone). Installs deps, runs pre-build steps, builds.

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
echo "Creating versions.json..."
echo '["latest", "v5.2.x"]' > versions.json

# ── Create versions-shipped.json ─────────────────────────────────────────────
echo "Creating versions-shipped.json..."
echo '["5.8.2", "5.8.1", "5.8.0", "5.7.4", "5.7.3", "4.3.0", "3.29.0", "2.15.0", "1.14.0"]' > versions-shipped.json

# ── Create versioned docs stubs ───────────────────────────────────────────────
echo "Creating versioned docs stubs..."
mkdir -p versioned_docs/version-latest
mkdir -p versioned_docs/version-v5.2.x

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

# ── Build ─────────────────────────────────────────────────────────────────────
echo "Running npm run build..."
npm run build

echo "[DONE] Build complete."
ls -la build/ 2>/dev/null || echo "No build dir found"
