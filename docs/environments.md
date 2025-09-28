# 🌍 Environments — tp154-infrastructure

This file describes the **Astra+ project environments** and their key characteristics for CI/CD, Terraform, and Helm deployment.

---

## 🟢 Development Environment
- **Automatic deployment:** after CI passes in service repositories.  
- **Cluster:** separate GKE cluster for development.  
- **Access:** all services are open for quick testing and debugging.  
- **Monitoring:** Prometheus, Grafana, AlertManager are active for metric collection.  

### Terraform Files
- Folder: `terraform/envs/development/`  
- Key files:
  - `terraform.tfvars` — variables for development  
  - `backend.tf` — Terraform backend configuration  
  - `secret.auto.tfvars` — **do not store in git**, contains secrets  
  - `GCP_SERVICE_ACCOUNT_KEY.json` — **do not store in git**, access key  
- Use `terraform plan` and `terraform apply` for test changes.  

### Helm
- Charts: `helm-charts/backend/` and `helm-charts/frontend/`  
- Files `env-values/values-development.yml` contain configurations for development.  
- Use `helm upgrade --install --values env-values/values-development.yml` for deployment.

---

## 🟡 Staging Environment
- **Manual deployment:** after successful Development.  
- **Cluster:** separate GKE cluster for staging.  
- **Access:** only Frontend is externally accessible; backend and database are internal.  

### Terraform Files
- Folder: `terraform/envs/staging/`  
- Key files:
  - `terraform.tfvars` — variables for staging  
  - `backend.tf` — Terraform backend configuration  
  - `secret.auto.tfvars` — **do not store in git**, contains secrets  
  - `GCP_SERVICE_ACCOUNT_KEY.json` — **do not store in git**, access key  

### Helm
- Charts: `helm-charts/backend/` and `helm-charts/frontend/`  
- Files `env-values/values-staging.yml` contain configurations for staging.  
- Use `helm upgrade --install --values env-values/values-staging.yml` for deployment.

---

## 🔴 Production Environment (planned)
- **Cluster:** separate GKE cluster.  
- **Access:** only Frontend via Ingress; backend and database are closed.  
- **TLS and Ingress:** cert-manager for secure access.  
- **Monitoring:** Prometheus, Grafana, AlertManager, Postgres Exporter for metric collection.  
- **Docker Images:** release tags are used; rollout through centralized CD (planned).  

### Terraform Files
- Folder: `terraform/envs/production/` (planned)  
- Key files: `terraform.tfvars`, `backend.tf` (with secrets stored separately).  

### Helm
- Use separate `values-production.yml` for backend/frontend charts (planned).  
- Access via Ingress, without exposing backend and database externally.

---

## 📚 Documentation
- [CI/CD](./ci-cd.md)  
- [Architecture](./architecture.md)  
- [Secrets](./secrets.md)  
- [Terraform](./terraform.md)  
- [Repository Structure](./repo-structure.md)  
