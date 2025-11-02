#!/bin/bash

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to install DNF packages if not already installed
install_dnf() {
    for pkg in "$@"; do
        if ! rpm -q "$pkg" &>/dev/null; then
            echo "Installing $pkg..."
            if ! sudo dnf install -y "$pkg"; then
                echo "Failed to install $pkg, skipping..."
            fi
        else
            echo "$pkg is already installed"
        fi
    done
}

# Enable COPR repos
sudo dnf copr enable -y solopasha/hyprland
sudo dnf copr enable -y erikreider/SwayNotificationCenter

# Install tools
install_dnf kitty waybar python3-pip git hyprland rofi hyprpaper hyprlock \
    fastfetch pipewire pipewire-pulse wireplumber pavucontrol brightnessctl \
    xorg-x11-server-Xwayland nwg-dock-hyprland nwg-look gtk-murrine-engine \
    nautilus gvfs gvfs-smb gvfs-afc gvfs-mtp ffmpegthumbnailer tumbler waypaper \
    NetworkManager-tui polkit-kde htop alsa-utils wlogout \
    SwayNotificationCenter pipewire-utils playerctl hyprshot bluez-tools blueman

# Add current user to video group for brightnessctl
sudo usermod -aG video $USER

# Install Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Install fonts
install_font() {
    local name=$1
    local url=$2
    sudo mkdir -p /usr/share/fonts/$name
    curl -Lo /tmp/$name.zip $url
    sudo unzip -o /tmp/$name.zip -d /usr/share/fonts/$name
    fc-cache -fv
    rm -f /tmp/$name.zip
}

install_font nerdfonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
install_font nerdfonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Arimo.zip
install_font iconly https://github.com/Val-VJD/VJD-Dotfile/raw/main/iconly.zip

# Install GTK and icon themes

git clone https://github.com/vinceliuice/Graphite-gtk-theme.git ~/Graphite-gtk-theme && \
cd ~/Graphite-gtk-theme && \
./install.sh
cd ~ && rm -rf ~/Graphite-gtk-theme

git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh black
cd ~ && rm -rf ~/Tela-icon-theme

# Install pywal via pip
pip install --user pywal
pip3 install --user requests

# Pre boot setup
echo "Starting Setup"

gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Tela-Black-Dark'
wal -i $SCRIPT_DIR/defaultwallpaper.png

echo "Finished Setup, you may proceed with installation"
