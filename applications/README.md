# applications

Each application is by default configured in its own folder. To prevent secret leakages and distintive secret generation, there are also `$HOSTNAME.sh` scripts, which generate the respective secrets for each host.

> Those scripts don't overwrite secrets if they already exist!

Therefore make sure to run them at least once before starting a new service.


# TODO

- It might make sense to move the contents of the `$HOSTNAME.sh` scripts to `$APPLICATION.sh` scripts, as they are actually not specific per host, but per application...
  Currently, this is sufficient, as most hosts are obviously still pets...
