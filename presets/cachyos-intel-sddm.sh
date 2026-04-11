#!/bin/bash
# Preset for fresh CachyOS/Arch installs on Intel graphics with SDDM.
# Usage: ./install.sh --preset presets/cachyos-intel-sddm.sh

# Prefer paru when the installer asks for an AUR helper.
# This value is ignored if an AUR helper is already installed.
aur_helper="paru"

# Preselect installer checklist options.
gtk_themes="ON"
bluetooth="ON"
thunar="ON"
quickshell="OFF"
sddm="ON"
sddm_theme="ON"
xdph="ON"
zsh="OFF"
pokemon="OFF"
rog="OFF"
dots="ON"
input_group="ON"
nvidia="OFF"
nouveau="OFF"
