#     _               _
#    | |             | |
#    | |__   __ _ ___| |__  _ __ ___
#    | '_ \ / _` / __| '_ \| '__/ __|
#   _| |_) | (_| \__ \ | | | | | (__
#  (_)_.__/ \__,_|___/_| |_|_|  \___|
#

# ///////////////////////// #

# Here is where you can configure Bash
# We recommand editing ~/.config/bashrc instead of the main .bashrc

# ///////////////////////// #

~/.config/bashrc/bashstartupsilenced.sh >/dev/null # Silenced
~/.config/bashrc/bashstartup.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

# ---------- #
# oh my posh #
# ---------- #

eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/quick-term.omp.json)"

# -------------------- #
# Bash startup scripts #
# -------------------- #

# ~/.config/bashrc/bashstartup.sh
# ~/.config/bashrc/bashstartupsilenced.sh >/dev/null # Silenced

unset rc
