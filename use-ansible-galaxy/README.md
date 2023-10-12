# Using the Ansible Galaxy Role

This guide provides step-by-step instructions on how to use the `030.ansible_mongodb_org_shell` role from Ansible Galaxy to install and configure the MongoDB shell (`mongosh`).

<br/>

## Table of Contents

- [Installation](#installation)
- [Playbook Creation](#playbook-creation)
- [Execution of Playbook](#execution-of-playbook)
- [Setting Role Variables (If Necessary)](#setting-role-variables-if-necessary)
- [Testing](#testing)
- [Role Documentation Review](#role-documentation-review)
- [Executing from Ansible Control Machine (ACM)](#executing-from-ansible-control-machine-acm)
- [Local Installation Using the Role](#local-installation-using-the-role)

<br/>

## Installation

1. Begin by downloading and installing the role:
    ```bash
    ansible-galaxy role install 030.ansible_mongodb_org_shell
    ```

2. You should see an output like:
    ```bash
    Starting galaxy role install process
    - downloading role 'ansible_mongodb_org_shell', owned by 030
    - downloading role from https://github.com/030/ansible-mongodb-org-shell/archive/1.0.0.tar.gz
    - extracting 030.ansible_mongodb_org_shell to /home/somaz/.ansible/roles/030.ansible_mongodb_org_shell
    - 030.ansible_mongodb_org_shell (1.0.0) was installed successfully
    ```

<br/>

## Playbook Creation

1. Next, create an Ansible playbook that utilizes the role:
    ```yaml
    ---
    - hosts: mongodb_servers
      become: yes
      roles:
        - 030.ansible_mongodb_org_shell
    ```
   - This playbook targets the `mongodb_servers` host group to install the MongoDB shell.

<br/>

## Execution of Playbook

1. Execute the playbook to apply the role's tasks:
    ```bash
    ansible-playbook your_playbook_name.yml
    ```

<br/>

## Setting Role Variables (If Necessary)

Some roles contain configurable variables. If you need to modify these, define them in the `vars` section of your playbook.

To discover available variables, check the `defaults/main.yml` file or the documentation for the `030.ansible_mongodb_org_shell` role. If required, modify the playbook to configure these variables:

```yaml
---
- hosts: mongodb_servers
  become: yes
  vars:
    some_variable: some_value
  roles:
    - 030.ansible_mongodb_org_shell
```

<br/>

## Testing
First, run the playbook in a test environment to ensure correct functionality. After validation, deploy it in your production environment.

<br/>

## Role Documentation Review
Each Ansible Galaxy role might come with unique usage instructions, configurations, or variable details. Always check the role's README or documentation for any additional configurations or usage methods.

By adhering to the above steps, you can efficiently utilize the 030.ansible_mongodb_org_shell role in an Ansible playbook to set up the MongoDB shell.

<br/>

## Executing from Ansible Control Machine (ACM)

If you're looking to execute the playbook from an ACM to a target host server, here are the steps and considerations:

1. **SSH Connectivity:** Ensure the ACM can SSH into the target host without requiring a password. Use the following command to copy the SSH key from the ACM to the host server:
    ```bash
    ssh-copy-id user@host_server_ip
    ```

2. **Inventory Configuration:** Ansible needs a list of servers it manages, typically through an inventory file. A sample `inventory.ini` might look like:
    ```ini
    [mongodb_servers]
    host_server_ip ansible_ssh_user=your_ssh_user
    ```

3. **Ansible Configuration:** Sometimes, you'll need an `ansible.cfg` configuration file to specify parameters such as the inventory file's location. Here's a simple example:
    ```ini
    [defaults]
    inventory = /path_to_your_directory/inventory.ini
    remote_user = your_ssh_user
    ```

4. **Playbook Execution:** While on the ACM, execute the playbook targeting the host server using:
    ```bash
    ansible-playbook -i inventory.ini your_playbook_name.yml
    ```

5. **Role Dependencies:** Before running the playbook, ensure all role dependencies are installed. The dependencies of a role are typically listed in the `meta/main.yml` file within the role. If the `dependencies` section in `meta/main.yml` is empty or not present, there are no external dependencies for the role and you can skip this step.

    If there are dependencies, they should be listed in a `requirements.yml` file within the role's directory. To install these dependencies, navigate to the role's directory and run:
    ```bash
    ansible-galaxy install -r requirements.yml
    ```
    Here, `requirements.yml` should list the dependencies as specified in the `meta/main.yml` file.

6. **Variables and Secrets:** For sensitive variables (e.g., database passwords), utilize `ansible-vault` to encrypt and use them securely with the playbook.

7. **Ensure Proper Privileges:** Some playbook tasks may require elevated privileges. If you're not using the root user, ensure the specified user has sudo privileges. In your playbook, you might need to include `become: yes` to elevate permissions.

By adhering to the above steps, your ACM will be set up to run the playbook against the target host server and install the MongoDB shell with the `030.ansible_mongodb_org_shell` role.

<br/>

## Local Installation Using the Role
If you intend to apply this role locally (i.e., on the machine where Ansible is being run), you can modify the playbook to target the localhost without the need for an inventory file.

Here's how you can adapt the playbook for a local installation:
```bash
---
- hosts: localhost
  connection: local
  become: yes
  tasks:
    - include_role:
        name: 030.ansible_mongodb_org_shell
```

When running the playbook with this configuration, Ansible will apply the role tasks to the local machine. Remember, as Ansible will make system changes, it's necessary to use the become: yes directive to ensure that tasks are executed with elevated privileges.

To run the playbook, simply use:
```bash
ansible-playbook your_local_playbook_name.yml
```

With this setup, there's no need to specify an inventory file or manage SSH keys for the localhost.