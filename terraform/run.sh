#!/bin/bash

set -e

ENV=$1

if [ -z "$ENV" ]; then
  echo "❌ Specify one of the environments located in envs/"
  exit 1
fi

TFVARS="envs/$ENV/terraform.tfvars"
SECRET="envs/$ENV/secret.auto.tfvars"
BACKEND="envs/$ENV/backend.tf"

if [ ! -f "$TFVARS" ]; then
  echo "❌ $TFVARS not found"
  exit 1
fi

if [ ! -f "$SECRET" ]; then
  echo "❌ $SECRET not found"
  exit 1
fi

echo "ℹ️ Environment used: $ENV"

# Copy backend.tf if it exists
if [ -f "$BACKEND" ]; then
  cp "$BACKEND" backend.tf
  echo "ℹ️ Conected backend.tf from $ENV"
fi

terraform init

terraform apply -auto-approve \
  -var-file="$TFVARS" \
  -var-file="$SECRET"

# Delete the temporary backend after execution
if [ -f "$BACKEND" ]; then
  rm backend.tf
  echo "🧹 Deleted the temporary backend.tf"
fi

echo "✅ Successfully completed for environment: $ENV"