Personal System Configuration
-----------------------------

Install config files with

    wget https://github.com/martyngigg/configs/raw/master/setup/setup.sh -q -O - | bash

This will clone the repository into `$HOME/.configs-repo` and symlink all of the config files into the relevant
locations. The clone will use `ssh` if possible, allowing write access in the future, but will fallback to anonymous
`https` if the appropriate ssh keys are not setup.

Usual packages are listed in setup/packages. Install standard packages with:

    cat setup/packages/ubuntu.txt | sudo xargs apt install -y
