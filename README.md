# iac
The code needed to deploy my homelab infrastructure.

## pet-devices
Some devices are special...
## magic-mirror
- When flashing the micro-SD card with `Raspberry OS Lite` with windows, make sure to remount it (so the partitions are read correctly).
  Afterwards add an empty file named `ssh` to the root of the boot-partition on the micro-SD card. Else, the pi doesn't have SSH enabled.
- Run `sudo apt update && sudo apt upgrade -y`
- Run `sudo apt install -y git`
- Run `git clone https://github.com/tillhoff/iac`
- Run `iac/initial/magic-mirror.sh -y`
- Run `iac/applications/magic-mirror.sh -y`, which triggers a reboot at the end.

## todo
- Don't recreate the zpools, try importing them first.
- what's the `configure-volume.sh` for?
