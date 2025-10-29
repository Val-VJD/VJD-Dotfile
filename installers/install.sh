#!/bin/bash

# install.sh for VJD Dotfile (Standard)

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Main execution flow ---

echo ' __      __  _ _____    _____        _    __ _ _      ';
echo ' \ \    / / | |  __ \  |  __ \      | |  / _(_) |     ';
echo '  \ \  / /  | | |  | | | |  | | ___ | |_| |_ _| | ___ ';
echo '   \ \/ /   | | |  | | | |  | |/ _ \| __|  _| | |/ _ \';
echo '    \  / |__| | |__| | | |__| | (_) | |_| | | | |  __/';
echo '     \/ \____/|_____/  |_____/ \___/ \__|_| |_|_|\___|';
echo '                                                      ';
echo '                                                      ';

while :; do
    printf "Thank you for using VJD Dotfiles, this installer will install the necessary dependecies for you. Please note that by using this installer, you agree to the terms and conditions that each package may have. Knowing this fact, would you like to continue? [y/n]: "
    read -r yn
    case $yn in
        [Yy]* ) echo "Continuing with installation..."; break;;
        [Nn]* ) echo "Installation cancelled."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sleep 2
clear

echo ' __      __  _ _____    _____        _    __ _ _      ';
echo ' \ \    / / | |  __ \  |  __ \      | |  / _(_) |     ';
echo '  \ \  / /  | | |  | | | |  | | ___ | |_| |_ _| | ___ ';
echo '   \ \/ /   | | |  | | | |  | |/ _ \| __|  _| | |/ _ \';
echo '    \  / |__| | |__| | | |__| | (_) | |_| | | | |  __/';
echo '     \/ \____/|_____/  |_____/ \___/ \__|_| |_|_|\___|';
echo '                                                      ';
echo '                                                      ';

while :; do
    printf "Are you sure you would like to continue? [y/n]: "
    read -r yn
    case $yn in
        [Yy]* ) echo "Continuing with installation..."; break;;
        [Nn]* ) echo "Installation cancelled."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sleep 2

if command -v dnf &> /dev/null; then
    ~/installers/fedorainstall.sh
else
    echo "Warning: Only Fedora is supported at this time, please install dependencies manually"
fi