#!/bin/bash
set -euo pipefail



# Ensure the system is up to date
sudo dnf update -y --refresh

# X server and drivers
sudo dnf -y install \
    glx-utils \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    plymouth-system-theme \
    xorg-x11-drv-evdev \
    xorg-x11-drv-fbdev \
    xorg-x11-drv-libinput \
    xorg-x11-drv-vesa \
    xorg-x11-server-Xorg \
    xorg-x11-server-utils \
    xorg-x11-utils \
    xorg-x11-xauth \
    xorg-x11-xinit \
    xbacklight \
    picom \
    xrandr \
    arandr \
    xsel \
    xclip \
    xkill

# Wireless drivers (the 7260 package contains firmwares for many other Intel cards too)
#dnf -y install \
#    iwl7260-firmware \
#    linux-firmware

# Desktop
sudo dnf -y install \
    bspwm \
    sxhkd \
    dmenu \
    lightdm \
    lightdm-gtk \
    firefox \
    feh
    
# Configurin BSPWM and SXHKD
mkdir -vp ~/.config/bspwm ~/.config/sxhkd
cp -v /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp -v /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/

cat ./xin > ~/.xinitrc

# System tools
sudo dnf -y install \
    udiskie \
    upower \
    xdg-utils \
    lm_sensors \
    xsensors \
    dbus-x11 \
    kitty \
    st \
    NetworkManager-tui \
    NetworkManager-wifi \
    net-tools \
    bind-utils \
    git \
    tmux \
    vim \
    whois \
    flameshot \
    traceroute \
    unzip \
    tree \
    htop \
    fzf \
    ranger

# Fonts
sudo dnf -y install \
    fontconfig \
    ibm-plex-mono-fonts \
    google-noto-sans-mono-fonts
    
# Optional Fonts for Asian languages (you'll encounter ugliness in browsers without these)
sudo dnf -y install \
    adobe-source-han-sans-cn-fonts \
    adobe-source-han-serif-cn-fonts \
    google-noto-sans-thai-fonts \
    google-noto-serif-thai-fonts \
    un-core-batang-fonts

# Codecs
sudo dnf -y install \
    gstreamer1 \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-free-gtk \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good

# Sound
sudo sudo dnf -y install \
    pulseaudio \
    pulseaudio-libs \
    pulseaudio-utils \
    alsa-plugins-pulseaudio \
    alsa-utils \
    pavucontrol \
    volumeicon

# Set graphical target and enable lightdm at boot
sudo systemctl enable lightdm.service
sudo systemctl set-default graphical.target

# Set RPM FUSION
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Boot into the new environment
sync
reboot
