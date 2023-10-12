# gce-lamp-deployment: LAMP Stack Deployment with Ansible

<br/>

## Overview

This guide illustrates how to deploy a LAMP (Linux, Apache, MySQL, PHP) stack on a server using the Ansible playbook in the `gce-lamp-deployment` project.

<br/>

## Pre-requisites

1. Apply `terraform-compute-engine` Source
2. SSH Key pair.
3. Ansible installed on your local machine.
4. Properly configured `inventory.ini` file.

<br/>

## Setup

### 1. Apply terraform-compute-engine Source

Create compute engines with terraform:
```bash
cd terraform-compute-engine
```
- Modify the variable values in the variables.tf file as necessary.

Initialize and apply Terraform configurations:
```bash
terraform init && terraform fmt
terraform validate
terraform apply
```

### 2. Copy SSH Key to Server

Ensure you can SSH into the target server without a password. 

Replace <YOUR_SERVER_NAME_OR_IP> with your server name or IP:
```bash
ssh-copy-id test-server
```

### 3. Encrypt Database Credentials

You need to encrypt the MySQL root and user passwords:
```bash
# Encrypt the root password
ansible-vault encrypt_string 'RootPassword123' --name 'mysql_root_password'

# Encrypt the user password
ansible-vault encrypt_string 'UserPassword456' --name 'new_user_password'
```
- Ensure you remember the vault password; you'll need it to run the playbook.

### 4. Test Ansible Connection

Before deploying, ensure Ansible can communicate with your server:
```bash
ansible all -i inventory.ini -m ping
```

### 5. Run the Ansible Playbook

Execute the playbook:
```bash
ansible-playbook -i inventory.ini site.yml --ask-vault-pass
```
- When prompted, enter the vault password.

### 6. Verify Installation

After the playbook runs successfully, verify that you can access the MySQL server:
```bash
mysql -u root -p
```

You can also check the databases:
```bash
mysql -u somaz -p

show databases;
```

<br/>

## Conclusion

You've successfully set up a LAMP stack using Ansible with the gce-lamp-deployment project. Ensure you store the vault password securely and follow best practices to keep your server secure.

