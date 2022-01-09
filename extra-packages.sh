#!/bin/bash
set -xe

sudo dnf install \
    make \
    automake \
    gcc \
    gcc-c++ \
    kernel-devel \
    bzip2 \
    cmake \
    dnf-utils \
    gimp \
    git \
    glibc-devel \
    glibc-headers \
    gparted \
    nmap \
    nmap-ncat \
    ntfs-3g \
    p7zip \
    python \
    python-devel \
    python-pip \
    python-virtualenv \
    rpm-build \
    rpmdevtools \
    rsync \
    steam \
    filezilla \
    winehq-staging \
    lutris \
    tar \
    bridge-utils \
    libvirt \
    virt-install \
    qemu-kvm \
    libvirt-devel \
    virt-top \
    libguestfs-tools \
    virt-manager \
    wget 

# Install Github Desktop
    sudo rpm --import https://packagecloud.io/shiftkey/desktop/gpgkey
    sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/shiftkey/desktop/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo' 
    sudo dnf -y install github-desktop

# Install VsCodium
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
    sudo dnf -y install codium

# Add Balena-Etcher Repo
    curl -1sLf \ 'https://dl.cloudsmith.io/public/balena/etcher/setup.rpm.sh' \ | sudo -E bash
    sudo dnf install -y balena-etcher-electron

# KVM daemon libvirtd is not started, start the service
    sudo systemctl start libvirtd
# Then enable the service to start on boot
    sudo systemctl enable libvirtd