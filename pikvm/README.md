# pikvm

## Installation

- Download and flash image to SD card
- Optional: To configure WiFi after first boot place `pikvm.txt` in root folder with the following contents:

```bash
# /pikvm.txt
FIRST_BOOT=1
WIFI_ESSID="mynet"
WIFI_PASSWD="p@s$$w0rd"
```

## Running playbook

Initially the host keys for the host(s) are not yet in the `~/.ssh/known_hosts` file. You can run `ansible-playbook` with additional ssh arguments or you can manually fetch the host keys before running the initial setup ansible playbook.

```bash
# Initial setup - stores host keys in ~/.ssh/known_hosts file
$ ansible-playbook setup.yaml -ask-pass --ssh-extra-args="-o StrictHostKeyChecking=no -o UpdateHostKeys=yes"

# Or to manually fetch host keys:
$ scripts/get_host_keys.sh pikvm.lan.besqua.red > ~/.ssh/known_hosts
$ ansible-playbook setup.yaml --ask-pass

# To revert the changes made by the setup.yaml playbook:
$ ansible-playbook setup-revert.yaml --ask-pass
```

## References

(PiKVM Handbook)[https://docs.pikvm.org/#links]

