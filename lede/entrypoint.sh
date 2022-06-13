#!/bin/bash

set -euxo pipefail

# read -p "please input you username > " USERNAME
# useradd -m -G sudo ${USERNAME}
echo "setting password for user ${USERNAME}:"
passwd ${USERNAME}
exec gosu ${USERNAME} "$@"
