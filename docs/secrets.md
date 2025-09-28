# 🔐 Secrets — tp154-infrastructure

This document describes the **secret management policy** in the **Astra+ project** and how to integrate them into CI/CD, Terraform, and Helm.

---

## 🗂 Types of Secrets

1. **Service Credentials**
   - `DB_USER`, `DB_PASSWORD` — for PostgreSQL database  
   - `BACKEND_CELERY_BROKER_URL`, `BACKEND_CELERY_RESULT_BACKEND` — for Celery  
   - `BACKEND_EMAIL_HOST_USER`, `BACKEND_EMAIL_HOST_PASSWORD` — for SMTP  

2. **Access Keys**
   - `GCP_SA_KEY` — GCP service account  
   - `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN` — for pushing images to Docker Hub  
   - `DJANGO_SECRET_KEY` — Django secret key  

3. **Environment Variables**
   - `GCP_PROJECT_ID`, `GKE_CLUSTER_NAME`, `GKE_CLUSTER_LOCATION`  

---

## 🛡 Secret Storage

- **GitHub Secrets** — for CI/CD (Actions, workflow_dispatch)  
- **Terraform**
  - Use `secret.auto.tfvars` for local secrets (do not add to git)  
- **Helm**
  - All secrets are stored in `values.yml` under the `secrets` key  
  - The `templates/secret.yml` template creates a Kubernetes Secret based on `.Values.secrets`  
  - When deploying via CD workflow, GitHub Secrets are injected using `--set secrets.X`  

---

## 🔑 Usage in CI/CD

- Secrets are accessed via GitHub Actions for `backend`:
  ```yaml
  env:
    DB_USER: ${{ secrets.DB_USER }}
    DB_PASSWORD: ${{ secrets.DB_PASSWORD }}
    BACKEND_EMAIL_HOST_USER: ${{ secrets.BACKEND_EMAIL_HOST_USER }}
    BACKEND_EMAIL_HOST_PASSWORD: ${{ secrets.BACKEND_EMAIL_HOST_PASSWORD }}
    BACKEND_CELERY_BROKER_URL: ${{ secrets.BACKEND_CELERY_BROKER_URL }}
    BACKEND_CELERY_RESULT_BACKEND: ${{ secrets.BACKEND_CELERY_RESULT_BACKEND }}
    DJANGO_SECRET_KEY: ${{ secrets.DJANGO_SECRET_KEY }}
  ```
- Helm charts use these secrets to create Kubernetes Secrets via `templates/secret.yml`.

---

## 📚 Documentation
- [CI/CD](./docs/ci-cd.md)  
- [Architecture](./docs/architecture.md)  
- [Environments](./docs/environments.md)  
- [Terraform](./docs/terraform.md)  
- [Repository Structure](./docs/repo-structure.md)  
