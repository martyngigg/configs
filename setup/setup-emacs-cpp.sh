#!/bin/bash
################################################################################
# setup-emacs-cpp.sh: Configures external tooling required for
#                     using Emacs as a C++ ide
# Author: Martyn Gigg
################################################################################

# ------------------------------------------------------------------------------
# CONSTANTS
# ------------------------------------------------------------------------------
NTHREADS=$(grep -c '^processor' /proc/cpuinfo)

# ------------------------------------------------------------------------------
# Compile RTags
# ------------------------------------------------------------------------------
# Check dependencies
_deps="clang libclang-dev cmake pkg-config bash-completion lua5.3"
_missing=""
for _dep in ${_deps}; do
    _query=`dpkg-query -l ${_dep} | grep -s -E "^ii"`
    if [ $? != 0 ]; then
        _missing="${_dep} ${_missing}"
    fi
done
if [ -n "${_missing}" ]; then
    echo "Missing '${_missing}' dependencies for RTags build"
    exit 1
fi

# Checkout & build RTags
_install_prefix=/usr/local
_rdm_bin=${_install_prefix}/bin/rdm
if [ ! -e ${_rdm_bin} ]; then
    _src_dir=/tmp/src/rtags
    _git_remote=https://github.com/Andersbakken/rtags.git
    if [ ! -d ${_src_dir} ]; then
        echo "Cloning RTags head from '${_git_remote}'"
        git clone --depth 1 --recursive ${_git_remote}  ${_src_dir}
    else
        echo "'${_src_dir}' exists. Skipping RTags clone."
    fi
    _build_dir=${_src_dir}-build
    test -d ${_build_dir} || mkdir -p ${_build_dir}
    cd ${_build_dir}
    echo
    echo "Building RTags in ${_build_dir}"
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_INSTALL_PREFIX=${_install_prefix} ${_src_dir}
    cmake --build . -- -j ${NTHREADS}

    echo
    echo "Installing RTags with prefix ${_prefix} (requires sudo, please enter password)"
    sudo cmake --build . --target install
else
    echo "Skipping RTags build as '${_rdm_bin}' command exists"
fi

echo
_rdm_socket=${HOME}/.config/systemd/user/rdm.socket
_rdm_service=${HOME}/.config/systemd/user/rdm.service
if [ ! -e ${_rdm_service} ]; then
    echo "Configuring systemd service for user '${USER}'"
    mkdir -p $(dirname ${_rdm_service})
    # socket file
    cat >${_rdm_socket} <<EOF
[Unit]
Description=RTags daemon socket

[Socket]
ListenStream=%h/.rdm

[Install]
WantedBy=multi-user.target
EOF

    # service file
    cat >${_rdm_service} <<EOF
[Unit]
Description=RTags daemon

Requires=rdm.socket

[Service]
Type=simple
ExecStart=/usr/local/bin/rdm --log-file=%h/.rtags/rdm.log --data-dir=%h/.rtags/rtags-cache --verbose --inactivity-timeout 300
EOF
    # enable
    systemctl --user enable rdm.socket
    systemctl --user start rdm.socket
else
    echo "Skipping systemd configuration as socket file '${_rdm_service}' file exists"
fi
