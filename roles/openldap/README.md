# xsrv.openldap

This role will install and configure [OpenLDAP](https://en.wikipedia.org/wiki/OpenLDAP), a [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol) directory server, and optionally the [LDAP Account Manager](https://ldap-account-manager.org/) web management interface

[![](https://screenshots.debian.net/screenshots/000/006/946/thumb.png)](https://screenshots.debian.net/package/ldap-account-manager)
[![](https://screenshots.debian.net/screenshots/000/016/087/thumb.png)](https://screenshots.debian.net/package/ldap-account-manager)


## Requirements/dependencies

- Ansible 2.9 or higher.
- [common](../common) role
- [apache](../apache) role (if `openldap_setup_lam` is enabled)
- [backup](../backup) role (optional, automatic backups)


## Role Variables

See [defaults/main.yml](defaults/main.yml)


## License

[GNU GPLv3](../../LICENSE)


## References

- https://stdout.root.sx/links/?searchtags=doc+ldap
- https://stdout.root.sx/links/?searchtags=doc+idmanagement


## Usage

- **CN**: Common Name (non-unique identifier for an entry, relative to the container it is in - eg `jane.doe`)
- **DN**: Distinguished Name (unique identifier, full path from root of the LDAP tree to the object - eg. `cn=jane.doe,ou=Users,dc=example,dc=org`)
- **DC**: Domain Component (component of a distinguished name - eg. `example, org`)
- **Base DN** or **Search base**: the top of your domain hierarchy, eg. `dc=CHANGEME,dc=org`
- **Users DN** container for the whole users hierarchy - eg. `ou=Users,dc=CHANGEME,dc=org`
- **OU**: [Organizational Unit](https://ldapwiki.com/wiki/OrganizationalUnit) (arbitrary subtree/subdirectory in LDAP hierarchy), for organizational/separation purposes - **not** permissions management purposes)
- **Group:** a list ([posixGroup](https://ldapwiki.com/wiki/PosixGroup)) of user DNs with a specific role/access level, for permissions management purposes - **not** organizational purposes. eg. `access_fileshare_XYZ`, `access_application_XYZ`, `access_instant_messaging`...)

**Backups:** see the included [rsnapshot configuration](templates/etc_rsnasphot.d_openldap.conf.j2) and [openldap dump script](templates/_user_local_bin_openldap-dump.sh.j2)

**Accessing LDAP account manager settings:** LAM should be configured from the templates provided by this role. If you need to temporarily access LAM settings from the web interface (your changes will be overwritten on the next ansible deployment), edit these files:
- `/var/www/{{ ldap_account_manager_fqdn }}/config/config.cfg`: `password: CHANGEME`
- `/var/www/{{ ldap_account_manager_fqdn }}/config/lam.conf`, `Passwd: CHANGEME`
