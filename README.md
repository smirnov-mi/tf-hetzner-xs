# tf-hetzner-xs
simplest terraform things for hetzner


## prereq.

- terraform


## create small servers with ubuntu24

Install Terraform on your local machine if you haven’t already.

Clone or copy the folder structure to your machine.

Make sure your ~/.ssh/id_ed25519 and ~/.ssh/id_ed25519.pub files exist.

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "your_email@example.com"
```


Set the TF_VAR_hcloud_token environment variable with your Hetzner Cloud API token.

```bash
export TF_VAR_hcloud_token=<your-api-token>
```

```bash
terraform init  # Initialize the Terraform working directory
terraform plan  # Preview the changes Terraform will make
terraform apply # Apply the configuration and create the resources

```
