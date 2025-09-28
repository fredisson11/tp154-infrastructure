# 🗂️ Repository Structure — tp154-infrastructure

This document describes the **complete repository structure** of the **Astra+ project** infrastructure and the purpose of key files and folders.  
The README.md contains only overview information for a quick start, while this document provides detailed information for DevOps engineers working with CI/CD and infrastructure.

> ⚠️ Temporary files, caches, local keys, and secrets (`.terraform/`, `*.tfstate`, `secret.auto.tfvars`, `GCP_SERVICE_ACCOUNT_KEY.json`, `.venv`, `__pycache__`, etc.) are ignored via `.gitignore` and are **intentionally not documented**.

---

## 📂 Main Structure

```
.
├── .github/workflows/        # CI/CD workflows for GitHub Actions
├── docs/                     # Documentation (architecture, processes, guides)
├── for-backend/              # CI/CD examples for backend services
├── for-frontend/             # CI/CD examples for frontend services
├── helm-charts/              # Helm charts for Kubernetes (backend & frontend)
├── terraform/                # Terraform infrastructure (GCP, Kubernetes, monitoring)
├── LICENSE                   # License
├── README.md                 # Overview README (DevOps-focused)
└── .gitignore                # Git ignore rules
```

---

## ⚙️ CI/CD — `.github/workflows/`

- **cd-main.yml** — centralized deployment pipeline (main CD).  
- **cd-reusable.yml** — jobs that can be reused in different workflows.  
- **README.md** — explanation of CI/CD processes.  

---

## 📖 Documentation — `docs/`

- **architecture.md** — infrastructure architecture (services, clusters, interactions).  
- **ci-cd.md** — description of CI/CD pipelines, principles, and best practices.  
- **environments.md** — environments (development, staging), their differences, and update policies.  
- **repo-structure.md** — this file; full repository structure.  
- **secrets.md** — secret management policy (GitHub Secrets, Vault, encryption).  
- **terraform.md** — working with Terraform: structure, modules, workflow, best practices.  

---

## 🖥 Backend CI — `for-backend/`

- **backend-ci.yml** — GitHub Actions pipeline for the backend service.  
- **Dockerfile** — example of a container for the backend.  
- **entrypoint.sh** — entry script for the container.  

---

## 🎨 Frontend CI — `for-frontend/`

- **frontend-ci.yml** — GitHub Actions pipeline for the frontend service.  
- **Dockerfile** — example of a container for the frontend.  

---

## 📦 Helm Charts — `helm-charts/`

### backend/
- **Chart.yaml** — Helm chart metadata.  
- **values.yaml** — default values.  
- **env-values/** — environments (development, staging).  
- **templates/** — Kubernetes resource templates (deployment, service, hpa, pvc, configmap, secrets).  
- **README.md** — chart documentation.  

### frontend/
- **Chart.yaml** — Helm chart metadata.  
- **values.yaml** — default values.  
- **env-values/** — environments (development, staging).  
- **templates/** — Kubernetes resource templates (deployment, service, hpa, pvc).  

---

## ☁️ Terraform — `terraform/`

- **main.tf** — main configuration.  
- **provider.tf** — providers (GCP, Kubernetes).  
- **locals.tf** — local variables.  
- **variables.tf** — global variables.  
- **Makefile** — convenient targets for working with Terraform (`init`, `plan`, `apply`, `refresh`, `destroy`, `fmt`, `clean`).  
- **run.sh** — script for automating Terraform runs.  

### envs/
- **development/** — infrastructure configuration for the development environment (`terraform.tfvars`, `backend.tf`).  
- **staging/** — infrastructure configuration for the staging environment.  

### modules/
- **firewall/** — network access rules.  
- **gke-cluster/** — module for creating GKE cluster.  
- **postgres/** — module for PostgreSQL.  
- **prometheus-stack/** — monitoring module (Prometheus, Grafana, AlertManager).  

---

## 📑 Other Files

- **LICENSE** — terms of use for the code.  
- **README.md** — overview file for new users.  
- **.gitignore** — list of files and directories to be ignored by Git.  

---

## 📚 Documentation
- [CI/CD](./ci-cd.md)  
- [Architecture](./architecture.md)  
- [Secrets](./secrets.md)  
- [Environments](./environments.md)  
- [Terraform](./terraform.md)  
