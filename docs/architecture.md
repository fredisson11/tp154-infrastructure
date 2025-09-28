# 🏗 Infrastructure Architecture — tp154-infrastructure

This file describes the **environment structure and component interactions** for the **Astra+ project**.  
Diagrams are created using Mermaid for clarity.  

---

## 🌍 Development Environment

> In Development, all microservices are exposed for external access via LB (LoadBalancer).  
> This is necessary for:
> - rapid testing of frontend/backend integrations;  
> - service debugging;  
> - testing Prometheus/Grafana/AlertManager in a real environment.

```mermaid
flowchart TD
  %% Development Environment
  subgraph "Development Environment"
    LB_DEV_FE[LB Frontend]
    LB_DEV_BE[LB Backend]
    LB_DEV_DB[LB Postgres]

    subgraph Dev_Cluster
      FE_DEV[Next.js Frontend]
      BE_DEV[Django Backend]
      DB_DEV[Postgres]
      subgraph Prom_Stack_Dev
        Prom_DEV[Prometheus]
        Graf_DEV[Grafana]
        AM_DEV[AlertManager]
      end
    end
  end

  %% External access in Dev
  LB_DEV_FE --> FE_DEV
  LB_DEV_BE --> BE_DEV
  LB_DEV_DB --> DB_DEV

  %% Internal connections
  FE_DEV --> BE_DEV
  BE_DEV --> DB_DEV
  FE_DEV --> Prom_DEV
  BE_DEV --> Prom_DEV
```

---

## 🌐 Staging Environment

> In Staging, access is open only to Frontend for limited testing.  
> Backend and database are accessible only inside the cluster.

```mermaid
flowchart TD
  %% Staging Environment
  subgraph "Staging Environment"
    LB_ST_FE[LB Frontend]

    subgraph Staging_Cluster
      FE_ST[Next.js Frontend]
      BE_ST[Django Backend]
      DB_ST[Postgres]
      subgraph Prom_Stack_ST
        Prom_ST[Prometheus]
        Graf_ST[Grafana]
        AM_ST[AlertManager]
      end
    end
  end

  %% External access in Staging (only Frontend)
  LB_ST_FE --> FE_ST

  %% Internal connections
  FE_ST --> BE_ST
  BE_ST --> DB_ST
  FE_ST --> Prom_ST
  BE_ST --> Prom_ST
```

---

## ⚡ Production Environment (planned)

> The Production environment is shown with dashed lines to emphasize that it **does not exist yet**.  
> Access is open only to Frontend via Ingress.  
> Backend and database are hidden from external access.  
> Monitoring includes **Postgres Exporter** and Prometheus/AlertManager/Grafana.

```mermaid
flowchart TD
  %% Production Environment (planned)
  subgraph "Production Environment"
    LB_PROD[LoadBalancer]

    %% Ingress
    Ingress_PROD[Ingress]

    subgraph Prod_Cluster
      FE_PROD[Next.js Frontend]
      BE_PROD[Django Backend]
      DB_PROD[Postgres]
      
      PGEXP_PROD[Postgres Exporter]

      subgraph Prom_Stack_PROD
        Prom_PROD[Prometheus]
        Graf_PROD[Grafana]
        AM_PROD[AlertManager]
      end
    end
  end

  %% External traffic
  LB_PROD --> Ingress_PROD
  Ingress_PROD --> FE_PROD

  %% Internal connections
  FE_PROD --> BE_PROD
  BE_PROD --> DB_PROD
  DB_PROD --> PGEXP_PROD
  PGEXP_PROD --> Prom_PROD
  FE_PROD --> Prom_PROD
  BE_PROD --> Prom_PROD

  %% Dotted style for planned Production
  classDef planned stroke-dasharray: 5, 5, color:#999;
  class LB_PROD,Ingress_PROD,FE_PROD,BE_PROD,DB_PROD,PGEXP_PROD,Prom_PROD,Graf_PROD,AM_PROD planned;
```

---

## 📚 Documentation
- [CI/CD](./docs/ci-cd.md)  
- [Secrets](./docs/secrets.md)  
- [Environments](./docs/environments.md)  
- [Terraform](./docs/terraform.md)  
- [Repository Structure](./docs/repo-structure.md)  
