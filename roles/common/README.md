common
=============

This role will install/configure a basic Debian-based server. 

- hostname
- DNS resolution (`/etc/resolv.conf`)
- sysctl/kernel settings: networking, swap/memory management, security
- APT package management, automatic daily security updates
- NTP date/time synchronization
- SSH server configuration/hardening
- firewall (`firehol`)
- Intrusion/bruteforce detention and prevention system (`fail2ban`)
- user accounts, resources, PAM restrictions
- (optional) creation of a user account for remote backups
- `sftponly` group: chrooted, SFTP-only accounts
- outgoing mail (through a SMTP relay)
- basic command-line utilities/diagnostic tools
- streamlining/Removal of unwanted packages
- `haveged` random number generator/entropy source for virtual machines

All configuration tasks are optional.

Requirements
------------

- Ansible 2.8 or higher
- Basic Debian GNU/Linux 9/10 netinstall on host
- Ansible inventory hostname resolves to the host FQDN (using DNS, /etc/hosts...)
- SSH server reachable from the controller
- User account on the host, member of the `sudo` group, for which you know the password
- Controller SSH key authorized on this user account (`ssh-copy-id user@host`)


Configuration variables
-----------------------

See [defaults/main.yml](defaults/main.yml)


Example playbook
-----------------

```yaml
- hosts: my.example.org
  roles:
     - common
  vars:
    setup_msmtp: yes

# ansible-vault edit host_vars/my.example.org/my.example.org.vault.yml
vault_msmtp_host: "smtp.CHANGEME.org"
vault_msmtp_username: "CHANGEME"
vault_msmtp_password: "CHANGEME"
vault_msmtp_admin_email: "CHANGEME@CHANGEME.org"
```


Usage
------------

 - SSH access: `ssh user@example.org`
 - SFTP access: `sftp://user@example.org` (clients: [Thunar](http://docs.xfce.org/xfce/thunar/start), [Nautilus](https://wiki.gnome.org/action/show/Apps/Nautilus), [Dolphin](https://www.kde.org/applications/system/dolphin/)), `sftp`, `rsync`, `scp`, Windows: [WinSCP](https://winscp.net/eng/index.php), PuTTY...)
- Force a power off: `ssh user@my.example.org sudo poweroff`
- Force an immediate reboot: `ssh user@my.example.org sudo reboot`
- Force purge of unused configuration files: `ssh user@my.example.org sudo aptitude -y purge ~c`
- Force rotation of system logs: `ssh user@my.example.org sudo logrotate -f /etc/logrotate.conf`
- If running in a KVM virtual machine in libvirt/virt-manager, to share a directory from the hypervisor to the VM: access VM settings in `virt-manager`. Click `Add hardware > Filesystem`, Set Mode: `Mapped`, Source path: `/path/to/the/directory/to/share` (on the hypervisor), Target path: `/exampleshareddirectory` (in the VM), then inside the VM run `sudo apt install 9mount, mount -t 9p /exampleshareddirectory /mnt/example`.
- Upgrade all packages without waiting for unattended-upgrades `ssh user@my.example.org 'sudo apt update && sudo apt upgrade'`
- Stop the firewall, allow all connections incoming/outgoing connections (be careful) `ssh user@my.example.org sudo firehol stop # or start` - or set `policy: ACCEPT` in firehol definitions for permanent effect
- Backups: nothing to backup. See the [backup](../backup/README.md) role.


License
-------

[GNU GPLv3](../../LICENSE)

References
-----------------

- https://stdout.root.sx/links/?searchtags=debian
- https://stdout.root.sx/links/?searchtags=dns
- https://stdout.root.sx/links/?searchtags=ssh
- https://stdout.root.sx/links/?searchtags=security
- https://stdout.root.sx/links/?searchtags=network
- https://stdout.root.sx/links/?searchtags=linux
- https://stdout.root.sx/links/?searchtags=admin
