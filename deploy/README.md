# HOW TO DEPLOY

> Make sure you have `terraform` and `azure-cli` installed.

## ADD YOUR SUB ID

- Go to `main.tf`
- Change sub with your own subscription_id.

## LOGIN TO AZURE

```bash
az login
```

## RUN

```bash
terraform init
terraform apply --auto-approve
```
