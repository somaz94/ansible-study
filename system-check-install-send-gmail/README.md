# System Check & Send Gmail 📧

This directory provides an Ansible playbook that executes a system-check script and subsequently sends the results through Gmail.

<br/>

## Directory Structure 📂

- `hosts.ini`: Inventory file which contains a list of hosts where the playbook should be executed.
- `system-check-install.yaml`: Ansible playbook that coordinates the entire system check and email sending process.
- `system-check.py`: Python script that conducts a system check and produces a detailed log.

<br/>

## Prerequisites 🛠

1. **Google App Password Configuration**: Before using the Gmail sending feature, ensure you've set up a [Google App Password](https://support.google.com/accounts/answer/185833?hl=en) for security and uninterrupted access.

2. **SSH Access Configuration**:
   Ensure you have SSH access to the target machines (in this example, `k8s-master` and `gitlab`). If you haven't done so, you can use the following commands to copy your SSH key to the target machines:

   ```bash
   ssh-copy-id k8s-master
   ssh-copy-id gitlab
   ```

<br/>

## Usage 🚀

1. Update the hosts.ini file with the correct IPs and other configurations of your target machines.

2. Modify the system-check-install.yaml playbook as needed, especially the email configurations.

3. Navigate to this directory and run:
```bash
ansible-playbook -i hosts.ini system-check-install.yaml
```

<br/>

## Notes 📋
Be cautious when sharing or pushing configurations, especially those containing sensitive data like email passwords.
