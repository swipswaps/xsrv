# Controller preparation

A **controller** machine will be used for deployment and remote administration.
The controller can be any laptop/desktop PC, dedicated server, VM or container where a SSH client, python and bash are available.
The controller will connect to your [hosts](server-preparation.md) using SSH and perform configuration tasks remotely.
On the controller:


```bash
# install requirements (example for debian-based systems)
sudo apt update && sudo apt install git bash python3-pip ssh pwgen

# clone the repository
sudo git clone -b release https://gitlab.com/nodiscc/xsrv /opt/xsrv # latest release
# sudo git clone -b 1.0 https://gitlab.com/nodiscc/xsrv /opt/xsrv # OR specific release
# sudo git clone -b master https://gitlab.com/nodiscc/xsrv /opt/xsrv # OR development version

# (optional) install the command line tool to your $PATH
sudo cp /opt/xsrv/xsrv /usr/local/bin/
```

_Note:_ it is also possible (but not recommended) to use the server itself as a controller. It will then configure itself without need for a SSH connection.
In that case, install/clone `xsrv` directly on the host, and set `connection: local` in the playbook for this host (on the same level as `roles:`) during the initial confiurations step.

Once the controller has been set up, it is time to [deploy](first-deployment.md) configuration to your hosts.
