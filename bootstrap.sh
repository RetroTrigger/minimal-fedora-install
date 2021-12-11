#!/bin/bash
set -euo pipefail


# Enable RPM Repo
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Ensure the system is up to date
sudo dnf update -y --refresh

# X server and drivers
sudo dnf -y install \
    akmod-nvidia \
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
    awesome \
    rofi \
    sddm \
    ImageMagick \
    feh
    
# System tools
sudo dnf -y install \
    xfce4-power-manager \
    nautilus \
    bluez \
    blueman \
    lxappearance \
    udiskie \
    xdg-utils \
    lm_sensors \
    xsensors \
    dbus-x11 \
    kitty \
    NetworkManager-tui \
    NetworkManager-wifi \
    net-tools \
    bind-utils \
    git \
    flameshot \
    traceroute \
    unzip \
    tree \
    htop \
    neofetch \
    fish \
    fzf 

# Make Theme folders
mkdir -p ~/.themes ~/.fonts

# Themes
sudo dnf -y install \
    juno-gnome-theme \

# Fonts
sudo dnf -y install \
    fontconfig \
    ibm-plex-mono-fonts \
    google-noto-sans-mono-fonts

sudo git clone https://github.com/perrychan1/fonts.git ~/.fonts/*    
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts   
fc-cache -vf

# Codecs
sudo dnf -y install \
    mpv \
    celluloid \
    gstreamer1 \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-free-gtk \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good

# Sound
sudo dnf -y install \
    pulseaudio \
    pulseaudio-libs \
    pulseaudio-utils \
    alsa-plugins-pulseaudio \
    alsa-utils \
    pavucontrol \
    volumeicon

# Install Brave Browser
sudo dnf -y install dnf-plugins-core

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf -y install brave-browser

# Set graphical target and enable lightdm at boot
sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target

# Change shell to fish
sudo dnf -y install util-linux-user
chsh -s /usr/bin/fish

# Fish Powerline Prompt
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5

# Copy Config Files
git clone https://github.com/RetroTrigger/minimal-fedora-install.git ~
cp -R ~/minimal-fedora-install/dotfiles/* ~/.config/
rm -rf ~/minimal-fedora-install

# Boot into the new environment
sync
reboot
