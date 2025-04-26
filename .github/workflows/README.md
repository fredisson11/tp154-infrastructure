# Infrastructure Deployment Workflows

This folder contains the centralized deployment pipeline for the backend application.

## Workflows

- **Backend CD Main** (`backend-cd-main.yml`):
  - Triggered via `workflow_dispatch` from the backend repository CI.
  - Steps:
    - Deploys to Development automatically
    - Saves deployment inputs as artifacts
    - Allows manual promotion to Staging using saved artifacts

- **Backend CD Reusable** (`backend-cd-reusable.yml`):
  - Reusable deployment workflow.
  - Handles:
    - Google Cloud authentication
    - Retrieving GKE cluster credentials
    - Helm chart validation and deployment

## Secrets and Variables

- **Repository Variables**:
  - `BACKEND_HELM_NAMESPACE`: Kubernetes namespace (e.g., `default`)
  - `BACKEND_HELM_RELEASE_NAME`: Helm release name (e.g., `backend`)
  - `DB_HOST`, `DB_PORT`: Database connection settings
  - `GKE_CLUSTER_LOCATION`: GCP cluster location

- **Environment Variables (per environment)**:
  - `DB_NAME`: Database name
  - `GKE_CLUSTER_NAME`: Name of the GKE cluster
  - `GCP_PROJECT_ID`: Google Cloud project ID

- **Repository Secrets**:
  - `DOCKERHUB_USERNAME`
  - `DOCKERHUB_TOKEN`
- **Environment Secrets (per environment)**:
  - `DB_USER`
  - `DB_PASSWORD`
  - `GCP_SA_KEY`: Google Cloud service account JSON key

## Architecture

- The backend repository pushes Docker images and triggers deployment.
- The infrastructure repository manages Kubernetes deployments through Helm.