#!/usr/bin/env bash
set -euo pipefail

# Folders that contain their own root configuration
TF_DIRS=("." "bootstrap")

# If a folder name is passed, check only that one
if [ $# -gt 0 ]; then
TF_DIRS=("$1")
fi

echo "==> Checking formatting across all folders (recursive)"
terraform fmt -check -recursive

for dir in "${TF_DIRS[@]}"; do
echo ""
echo "==> Validating: $dir"
terraform -chdir="$dir" init -backend=false -input=false > /dev/null
terraform -chdir="$dir" validate
done

for dir in "${TF_DIRS[@]}"; do
echo ""
echo "==> Planning: $dir"
terraform -chdir="$dir" plan -input=false
done

echo ""
echo "All checks passed."