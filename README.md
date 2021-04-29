# iac

The code needed to deploy my homelab infrastructure.


## usage

- The `Taskfile.yml` contains all day-to-day tasks.
- The respective folders contain scripts/configuration for specific parts (which are specified in the folder name).
- In most folders, the scripty are named after hosts (`$HOSTNAME.sh`) - within them is a validator wheter the script is run on the correct host. That can be skipped though.
- `*.secret` files are encrypted automatically IF transcrypt is configured properly. It is included in this repo, just to make sure there won't be problems in the future.
- `*.ignored` files are ignored automatically by git.


## pet-devices

Some devices are special, so their bootstrapping is written down here.


### magic-mirror

- When flashing the micro-SD card with `Raspberry OS Lite` with windows, make sure to remount it (so the partitions are read correctly).
  Afterwards add an empty file named `ssh` to the root of the boot-partition on the micro-SD card. Else, the pi doesn't have SSH enabled.
- Run `sudo apt update && sudo apt upgrade -y`
- Run `sudo apt install -y git`
- Run `git clone https://github.com/tillhoff/iac`
- Run `iac/initial/magic-mirror.sh -y`
- Run `iac/applications/magic-mirror.sh -y`, which triggers a reboot at the end.


## decisions

For my future self, I want to write down some decisions I've made earlier on, so I won't get confused/distracted.


### documentation

Each relevant folder must contain a `README.md` to explain the contents. This is to ensure my future self doesn't need to rethink stuff all the time.


### databases

As long as docker-compose is the chosen application-deployment-framework, each application should have its own full database. While this might be some overhead, it simplifies service management (a simple `up`/`down` is sufficient to up/down the whole service including its database), debugging capabilities and allows for distinct storage configuration.
This was initially drived by the reason, that there is no "database on demand" which can do the same (with docker-compose).


## todo
- Don't recreate the zpools, try importing them first.
- what's the `configure-volume.sh` for?
