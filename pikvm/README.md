# pikvm <!-- omit in toc -->

- [Pre installation](#pre-installation)
- [Installation](#installation)
  - [Step I](#step-i)
  - [Step II](#step-ii)
  - [Step III](#step-iii)
- [Running playbook](#running-playbook)
- [References](#references)

## Pre installation

- Download and flash image to SD card
- Optional: To configure WiFi after first boot place `pikvm.txt` in root folder with the following contents:

```bash
# /pikvm.txt
FIRST_BOOT=1
WIFI_ESSID="mynet"
WIFI_PASSWD="p@s$$w0rd"
```

## Installation

### Step I

Install the Ansible Galaxy roles required for this playbook.

```bash
# Install required roles/dependencies
$ ansible-galaxy install --roles-path ./roles -r requirements.yaml
```

### Step II

Verify the inventory file `hosts` and check that it is correct.

### Step III

Initially the host keys for the host(s) are not yet in the `~/.ssh/known_hosts` file. You can run `ansible-playbook` with additional ssh arguments or you can fetch the host keys before running the initial setup ansible playbook.

<details>
<summary><strong>How to fetch host keys</strong></summary>

```bash
$ scripts/get_host_keys.sh pikvm.lan.besqua.red > ~/.ssh/known_hosts
$ ansible-playbook plays/setup.yaml --ask-pass
```
</details>

<details>
<summary><strong>What if 'root' user login is disabled by previous playbook runs</strong></summary>

```bash
# Command to run Ansible with 'pikvm' user (assuming it has sudo privileges)
$ ansible-playbook plays/setup.yaml --ask-become-pass -e ansible_user=pikvm -e ansible_ssh_private_key_file=~/.ssh/id_rsa_pikvm
```
</details>

```bash
# Initial setup - stores host keys in ~/.ssh/known_hosts file
$ ansible-playbook plays/setup.yaml --ask-pass --ssh-extra-args="-o StrictHostKeyChecking=no -o UpdateHostKeys=yes"
```

## Running playbook

<details>
<summary><strong>How to generate new SSH key</strong></summary>

```bash
# Example of command to generate new SSH key
$ ssh-keygen -C "pikvm.lan.besqua.red (pikvm)" -t rsa -b 4096 -N "<your-optional-key-passphrase>" -f ~/.ssh/id_rsa_pikvm
```
</details>

```bash
# SSH hardening
$ ansible-playbook plays/ssh.yaml

# Configure pikvm (without variable prompts)
$ ansible-playbook plays/pikvm.yaml
# Configure pikvm (with variable prompts)
$ ansible-playbook plays/pikvm.yaml -e user=pikvm -e password=pikvm -e ssh_key_file=~/.ssh/id_rsa_pikvm
```

## References

[PiKVM Handbook]

[PiKVM Handbook]:https://docs.pikvm.org/#links
