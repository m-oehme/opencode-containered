#!/bin/bash
set -e

# Get latest version from pacman (exact match)
LATEST=$(curl -s "https://archlinux.org/packages/extra/x86_64/opencode/json/" | \
  jq -r '.pkgver')

# Get current version from GitHub tags
CURRENT=$(curl -s "https://api.github.com/repos/$1/tags" | \
  jq -r '.[0].name' | sed 's/^v//')

# Fallback to local VERSION file
if [ -z "$CURRENT" ] && [ -f VERSION ]; then
  CURRENT=$(cat VERSION)
fi

CURRENT=${CURRENT:-""}

# Set GitHub outputs
echo "latest_version=$LATEST" >> $GITHUB_OUTPUT
echo "current_version=$CURRENT" >> $GITHUB_OUTPUT

# Determine if build is needed
if [ "$2" == "true" ] || [ "$LATEST" != "$CURRENT" ]; then
  echo "needs_build=true" >> $GITHUB_OUTPUT
else
  echo "needs_build=false" >> $GITHUB_OUTPUT
fi