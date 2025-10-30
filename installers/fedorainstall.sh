#!/bin/bash

set -e

# Function to install DNF packages if not already installed
install_dnf() {
    for pkg in "$@"; do
        if ! rpm -q $pkg &>/dev/null; then
            sudo dnf install -y $pkg
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
    xorg-x11-server-Xwayland nwg-dock-hyprland nwg-look nwg-drawer gtk-murrine-engine \
    nautilus gvfs gvfs-smb gvfs-afc gvfs-mtp ffmpegthumbnailer tumbler waypaper \
    NetworkManager-tui polkit-kde vlc kwrite htop alsa-utils wlogout \
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
install_theme() {
    local repo=$1
    local theme_dir=$2
    git clone $repo ~/$theme_dir
    cd ~/$theme_dir
    ./install.sh
    cd ~
    rm -rf ~/$theme_dir
}

install_theme https://github.com/vinceliuice/Graphite-gtk-theme.git Graphite-gtk-theme
install_theme https://github.com/vinceliuice/Tela-icon-theme.git Tela-icon-theme

# Install pywal via pip
pip install --user pywal
pip3 install --user requests

# Make Symlinks
echo "Making symlinks"

mkdir -p ~/.config/waybar/colors
mkdir -p ~/.config/nwg-dock-hyprland/colors
mkdir -p ~/.config/wlogout/colors
mkdir -p ~/.config/swaync/colors

ln -s ~/.cache/wal/colors.css ~/.config/swaync/colors/colors.css
ln -s ~/.cache/wal/colors.css ~/.config/waybar/colors/colors.css
ln -s ~/.cache/wal/colors.css ~/.config/nwg-dock-hyprland/colors/colors.css
ln -s ~/.cache/wal/colors.css ~/.config/wlogout/colors/colors.css