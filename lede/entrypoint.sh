#!/bin/bash

set -euxo pipefail

# handling restart(stop&start) cases.
if ! id -u ${USERNAME} &>/dev/null; then
    groupadd -g ${GID} ${USERNAME}
    useradd -m -u ${UID} -g ${GID} -G sudo ${USERNAME}
    # chown -R ${UID}:${GID} "${WORKDIR}"
    echo "setting password for user ${USERNAME}:"
    passwd ${USERNAME}
fi

cd ${WORKDIR} && exec gosu ${USERNAME} "$@"