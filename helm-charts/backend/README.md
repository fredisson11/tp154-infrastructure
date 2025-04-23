# Backend Helm Chart

A Helm chart for deploying a Python-based backend application with PostgreSQL support.  
Includes support for HPA, ConfigMap, Secrets, and health-check probes.

---

## ⚠️ Required Values

This chart uses placeholder defaults.  
You must override these values using `--set` or a separate values file before installation.

### Example minimal installation:

```bash
helm install backend ./backend \
  --set image.repository=ghcr.io/your-name/backend \
  --set image.tag=2.0.3 \
  --set config.DB_HOST=postgres-service.default.svc.cluster.local \
  --set config.DB_PORT=5432 \
  --set config.DB_NAME=mydb \
  --set secrets.DB_USER=myuser \
  --set secrets.DB_PASSWORD=securepass