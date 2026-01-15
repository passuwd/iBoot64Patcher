#!/usr/bin/env bash

set -e
export TMPDIR=/tmp
export WORKFLOW_ROOT=${TMPDIR}/Builder/repos/iBoot64Patcher/.github/workflows
export DEP_ROOT=${TMPDIR}/Builder/repos/iBoot64Patcher/dep_root

# Обновление системы
apt-get update -qq
apt-get upgrade -yqq

# Установка основных зависимостей
apt-get install -yqq \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    tar \
    zstd \
    pkg-config \
    clang-14 \
    clang++-14 \
    lld-14 \
    llvm-14-dev \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libbz2-dev

# Симлинки для компиляторов
ln -sf /usr/bin/clang-14 /usr/bin/clang
ln -sf /usr/bin/clang++-14 /usr/bin/clang++
ln -sf /usr/bin/ld.lld-14 /usr/bin/ld

cd ${WORKFLOW_ROOT}

# Загрузка зависимостей проекта
curl -sO https://cdn.cryptiiiic.com/deps/static/Linux/x86_64/Linux_x86_64_Release_Latest.tar.zst
curl -sO https://cdn.cryptiiiic.com/deps/static/Linux/x86_64/Linux_x86_64_Debug_Latest.tar.zst

mkdir -p ${DEP_ROOT}/Linux_x86_64_{Release,Debug}
tar xf Linux_x86_64_Release_Latest.tar.zst -C ${DEP_ROOT}/Linux_x86_64_Release
tar xf Linux_x86_64_Debug_Latest.tar.zst -C ${DEP_ROOT}/Linux_x86_64_Debug

# Очистка
rm -f *.zst
