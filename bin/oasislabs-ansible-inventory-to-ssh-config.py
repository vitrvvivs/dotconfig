#!/usr/bin/env python3

from time import sleep
from typing import cast
from inotify.adapters import InotifyTree  # https://pypi.org/project/inotify/
import os
import yaml
from pathlib import Path
from pprint import pprint
from ssh_config import SSHConfig, Host  # https://pypi.org/project/ssh-config/

# in ~/.ssh/config :
#   Include ~/.ssh/config_auto

USER = "vitrvvivs"
CACHE_DIR = Path("/tmp/oasislabs-private-ops-ansible-cache/")
SSH_CONFIG = Path("~/.ssh/config_auto").expanduser()

def file_updated(file_path: Path):
    conf = SSHConfig(SSH_CONFIG)
    inv = yaml.load(file_path.open(), Loader=yaml.FullLoader)
    for _, hosts in inv.items():
        for host_dict in hosts:
            hostname = host_dict['hostname']
            ip = host_dict['ansible_host']

            if not conf.exists(hostname):
                host = Host(hostname, {
                    'HostName': ip,
                    'User': USER,
                    'SetEnv': 'TERM=xterm',
                })
                conf.add(host)
    conf.write()

if __name__ == "__main__":
    SSH_CONFIG.touch()
    while not CACHE_DIR.exists():
        sleep(30)

    files = os.listdir(CACHE_DIR)
    for file in files:
        if file.startswith("ansible_inventory"):
            print(CACHE_DIR / file)
            file_updated(CACHE_DIR / file)

    inotify = InotifyTree(str(CACHE_DIR))
    for event in inotify.event_gen(yield_nones=False):
        event = cast(tuple, event)
        (_, type_names, path, filename) = event
        if 'IN_MOVED_TO' in type_names and filename.startswith("ansible_inventory"):
            pprint(event)
            file_updated(Path(path) / filename)
