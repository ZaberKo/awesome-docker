#!/bin/bash

set -euxo pipefail

# read -p "please input you username > " USERNAME
# useradd -m -G sudo ${USERNAME}
passwd ${USERNAME}
gosu ${USERNAME} /bin/bash
