nginx
====

This role will install and configure the [Nginx](https://en.wikipedia.org/wiki/Nginx) webserver.


Requirements/Dependencies
------------

- Ansible 2.9 or higher.
- [`common`](https://gitlab.com/nodiscc/xsrv/-/tree/master/roles/common) role (optional)
- For Let's Encrypt certificates, port 80/tcp must be reachable from the Internet, and the virtualhost ServerName must have a record in the public DNS system


Configuration Variables
-----------------------

See [defaults/main.yml](defaults/main.yml)


Example Playbook
----------------

```yaml
- hosts: my.example.org
  roles:
     - common
     - nginx
```


License
-------

[GNU GPLv3](../../LICENSE)


References
-----------------

- https://stdout.root.sx/links?searchtags=nginx
- https://stdout.root.sx/links?searchtags=ssl
- https://stdout.root.sx/links?searchtags=php
- https://stdout.root.sx/links?searchtags=web
