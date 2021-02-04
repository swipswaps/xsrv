# xsrv.docker

An Ansible Role that installs [Docker](https://www.docker.com) on Linux.

## Requirements/Dependencies/example playbook

See [`meta/main.yml`](meta/main.yml)

```yaml
# playbook.yml
- hosts: my.CHANGEME.org
  roles:
    - common
    - monitoring # optional
    - docker
```

See [`defaults/main.yml`](meta/main.yml) for all configuration variables.

## License

[MIT](https://opensource.org/licenses/MIT)


## References

- https://github.com/geerlingguy/ansible-role-docker
- https://stdout.root.sx/links/?searchtags=doc+docker
