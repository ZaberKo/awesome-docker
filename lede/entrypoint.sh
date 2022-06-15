#!/bin/bash

set -euxo pipefail

# handling restart(stop&start) cases.
if ! id -u ${USERNAME} &>/dev/null; then
    useradd -m -G sudo ${USERNAME}
    echo "setting password for user ${USERNAME}:"
    passwd ${USERNAME}
fi

cd ${WORKDIR} && exec gosu ${USERNAME} "$@"