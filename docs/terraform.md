# 🏗 Terraform — tp154-infrastructure

This document describes the use of **Terraform for managing the infrastructure** of the **Astra+ project**.  
The structure of files and modules is designed to separate environments and promote code reuse.

---

## 📦 Modules
- **gke-cluster** — creating and configuring the GKE cluster.  
- **postgres** — PostgreSQL configuration (PVC, database settings).  
- **firewall** — network access rules.  
- **prometheus-stack** — monitoring (Prometheus, Grafana, AlertManager).

---

## 🌍 Environments (Envs)
- **development/** — configurations for the Development environment.  
- **staging/** — configurations for the Staging environment.  

### Files in each env:
- `terraform.tfvars` — environment-specific variables.  
- `backend.tf` — Terraform backend configuration (state storage).  
- `secret.auto.tfvars` — secret variables (do not store in git).  
- `GCP_SERVICE_ACCOUNT_KEY.json` — GCP access key (do not store in git).  

---

## 🛠️ Makefile and run.sh

### Makefile
- Targets: init, plan, apply, destroy, refresh, fmt, clean
- Uses the ENV variable to determine the environment
- Automatically connects the `backend.tf` from the environment folder and removes it after execution

### run.sh
- Usage: `./run.sh <environment>`
- Checks for the existence of tfvars, secrets, and backend
- Initializes Terraform and applies changes
- Cleans up the temporary backend after execution

---

## 🛠️ Common Commands
```bash
# Navigate to the environment folder
cd terraform/envs/development

# Initialize Terraform
terraform init

# Check for changes
terraform plan

# Apply changes
terraform apply
```

> 🔑 For staging, replace `development` with `staging` in the path.

---

## 📚 Documentation
- [CI/CD](./ci-cd.md)  
- [Architecture](./architecture.md)  
- [Secrets](./secrets.md)  
- [Environments](./environments.md)  
- [Repository Structure](./repo-structure.md)  
