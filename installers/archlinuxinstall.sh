#!/bin/bash

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if yay is installed
if ! command -v yay &>/dev/null; then
    echo "Error: 'yay' is not installed. Please install yay before running this script."
    echo "You can install it with:"
    echo "  sudo pacman -S --needed git base-devel"
    echo "  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    exit 1
fi

sudo pacman -S --needed --noconfirm gcc make pkgconf openssl

# Remove old binaries that might conflict
sudo rm -f /usr/bin/hyprutils /usr/bin/hypryou-utils /usr/bin/hyprpaper

# Function to install pacman packages if not already installed
install_pacman() {
    for pkg in "$@"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
            echo "Installing $pkg..."
            if ! sudo pacman -S --needed --noconfirm "$pkg"; then
                echo "Failed to install $pkg, skipping..."
            fi
        else
            echo "$pkg is already installed"
        fi
    done
}

# Install official repo packages
install_pacman kitty waybar python-pip git hyprland nwg-drawer hypridle hyprlock \
    fastfetch pipewire pipewire-pulse wireplumber pavucontrol brightnessctl \
    xorg-xwayland nwg-look gtk-engine-murrine nautilus gvfs gvfs-smb gvfs-afc gvfs-mtp \
    ffmpegthumbnailer tumbler networkmanager polkit-gnome htop alsa-utils wlogout \
    pipewire-utils playerctl bluez bluez-utils blueman curl unzip matugen waypaper \
    swaync nwg-dock-hyprland \

# Add current user to video group for brightnessctl
sudo usermod -aG video $USER

# Install AUR packages via yay
yay -S --needed --noconfirm hyprshot

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
install_font iconly https://github.com/Val-VJD/VJD-Dotfile/raw/main/fonts/iconly.zip
install_font googlefonts https://github.com/Val-VJD/VJD-Dotfile/raw/main/fonts/Silkscreen-Regular.zip

# GTK and icon themes
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git ~/Graphite-gtk-theme && \
cd ~/Graphite-gtk-theme && ./install.sh
cd ~ && rm -rf ~/Graphite-gtk-theme

# Install requests via pip
sudo pacman -S python-requests

# Pre boot setup
echo "Starting Setup"

gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'
matugen image "$SCRIPT_DIR/defaultwallpaper.png"

echo "Setting permanent PATH for systemd user session..."
mkdir -p "$HOME/.config/environment.d"
echo "PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$PATH" > "$HOME/.config/environment.d/path.conf"

echo "Finished Setup, you may proceed with installation"
