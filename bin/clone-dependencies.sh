#!/usr/bin/env bash

# This script clones the dependencies of the BlazingMQ Python SDK that are not
# in a package manager.  This script should not be run by users directly, but
# is instead sourced by the `./build-*.sh` scripts in this directory.


set -e
set -u
[ -z "$BASH" ] || shopt -s expand_aliases


# These are the release tags for each of the dependencies we manually clone.
# Update these to update the version of each dependency we build against.
BDE_TOOLS_TAG=4.39.0.0
BDE_TAG=4.39.0.0
NTF_CORE_TAG=2.6.12
OPENSSL_TAG=3.5.9
# NOTE(arnaud) TLS client support (bloomberg/blazingmq#1600) is not merged
# upstream yet: build against the tls branch of the fork (upstream
# main plus #1600), pinned to a commit
BLAZINGMQ_REPO=https://github.com/arnaudmorin/blazingmq.git
BLAZINGMQ_TAG=fcea3c3a9b95b985252f602d11625bbcf323d254  # tls branch


if [ ! -d "${DIR_THIRDPARTY}/bde-tools" ]; then
    git clone                                                                  \
        https://github.com/bloomberg/bde-tools                                 \
        "${DIR_THIRDPARTY}/bde-tools"
    git -C "${DIR_THIRDPARTY}/bde-tools" checkout ${BDE_TOOLS_TAG}
fi

if [ ! -d "${DIR_THIRDPARTY}/bde" ]; then
    git clone                                                                  \
        https://github.com/bloomberg/bde.git                                   \
        "${DIR_THIRDPARTY}/bde"
    git -C "${DIR_THIRDPARTY}/bde" checkout ${BDE_TAG}
fi

if [ ! -d "${DIR_THIRDPARTY}/ntf-core" ]; then
    git clone                                                                  \
        https://github.com/bloomberg/ntf-core.git                              \
        "${DIR_THIRDPARTY}/ntf-core"
    git -C "${DIR_THIRDPARTY}/ntf-core" checkout ${NTF_CORE_TAG}
fi

if [ ! -d "${DIR_THIRDPARTY}/blazingmq" ]; then
    git clone                                                                  \
        ${BLAZINGMQ_REPO}                                                      \
        "${DIR_THIRDPARTY}/blazingmq"
    git -C "${DIR_THIRDPARTY}/blazingmq" checkout ${BLAZINGMQ_TAG}
fi
