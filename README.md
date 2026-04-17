# Platform Infrastructure

Terraform IaC for the lsuthar.in platform. Manages infrastructure across 4 cloud providers: Civo, AWS, Azure DevOps, and Cloudflare.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     lsuthar.in Platform                      │
├──────────────┬──────────────┬──────────────┬────────────────┤
│     Civo     │     AWS      │    Azure     │   Cloudflare   │
│  K8s Cluster │  EC2 + EIP   │  DevOps      │  DNS + Workers │
│  MUM1 region │  ap-south-1  │  Pipelines   │  8 Workers     │
└──────────────┴──────────────┴──────────────┴────────────────┘
```

## Module Structure

```
terraform/
├── main.tf                    # Root module — calls all modules
├── variables.tf               # Root variables
├── providers.tf               # Provider configuration
├── versions.tf                # Provider version constraints
├── terraform.tfvars.example   # Example vars (safe to commit)
└── modules/
    ├── civo/                  # Civo K8s cluster
    │   ├── main.tf
    │   ├── variables.tf
    │   └── versions.tf
    ├── aws/                   # EC2 + Elastic IP
    │   ├── main.tf
    │   ├── variables.tf
    │   └── versions.tf
    ├── azure/                 # Azure DevOps project + pipelines
    │   ├── main.tf
    │   ├── variables.tf
    │   └── versions.tf
    └── cloudflare/            # DNS records
        ├── main.tf
        ├── variables.tf
        └── versions.tf
```

## Managed Resources

### Civo
- K8s cluster `Platform` — 2 × g4s.kube.large nodes (8GB RAM, 4 CPU), MUM1

### AWS
- EC2 t3.micro — Audio Service (Ubuntu 22.04)
- Elastic IP — `13.63.189.209`

### Azure DevOps
- Project: `platform`
- Pipeline: `feature-flag-service`
- Pipeline: `auth-service`
- Pipeline: `api-gateway`

### Cloudflare
- A record: `api.lsuthar.in` → `212.2.248.221`
- A record: `flags.lsuthar.in` → `212.2.248.221`
- A record: `grafana.lsuthar.in` → `212.2.248.221`
- A record: `logs.lsuthar.in` → `212.2.248.221`
- A record: `audio.lsuthar.in` → `13.63.189.209`

## Prerequisites

- Terraform >= 1.5.0
- Civo API token
- AWS credentials (access key + secret)
- Azure DevOps PAT
- Cloudflare API token

## Setup

```bash
cd terraform

# Copy example vars
cp terraform.tfvars.example terraform.tfvars
# Fill in terraform.tfvars with your values

# Set sensitive values as env vars
export TF_VAR_civo_token="your-civo-token"
export TF_VAR_aws_access_key="your-aws-key"
export TF_VAR_aws_secret_key="your-aws-secret"
export TF_VAR_azure_pat="your-azure-pat"
export TF_VAR_cloudflare_api_token="your-cf-token"

terraform init
terraform plan
terraform apply
```

## Import Existing Resources

All resources were imported from existing infrastructure:

```bash
terraform import module.civo.civo_kubernetes_cluster.platform <cluster-id>
terraform import module.aws.aws_instance.audio_service <instance-id>
terraform import module.aws.aws_eip.audio_service <allocation-id>
terraform import module.azure.azuredevops_project.platform <project-id>
terraform import module.cloudflare.cloudflare_record.api <zone-id>/<record-id>
```

## Security

- `terraform.tfvars` is gitignored — never commit it
- `*.tfstate` files are gitignored — store remotely in production
- All secrets passed via environment variables or K8s secrets
