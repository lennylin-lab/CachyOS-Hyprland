#!/bin/bash
set -euo pipefail

packages=(
    hyprland
    hyprlock
    hypridle
    waybar
    swaync
    sddm
    pipewire
    wireplumber
    pipewire-pulse
    xdg-desktop-portal-hyprland
)

user_units=(
    pipewire.service
    pipewire-pulse.service
    wireplumber.service
)

failures=0

check_pkg() {
    local pkg="$1"
    if pacman -Q "$pkg" >/dev/null 2>&1; then
        printf '[ok] package: %s\n' "$pkg"
    else
        printf '[missing] package: %s\n' "$pkg"
        failures=1
    fi
}

check_file() {
    local path="$1"
    if [[ -e "$path" ]]; then
        printf '[ok] path: %s\n' "$path"
    else
        printf '[missing] path: %s\n' "$path"
        failures=1
    fi
}

check_user_unit() {
    local unit="$1"
    if systemctl --user is-enabled "$unit" >/dev/null 2>&1; then
        printf '[ok] user unit enabled: %s\n' "$unit"
    else
        printf '[warn] user unit not enabled: %s\n' "$unit"
        failures=1
    fi
}

check_system_unit() {
    local unit="$1"
    if systemctl is-enabled "$unit" >/dev/null 2>&1; then
        printf '[ok] system unit enabled: %s\n' "$unit"
    else
        printf '[warn] system unit not enabled: %s\n' "$unit"
        failures=1
    fi
}

printf '== Package audit ==\n'
for pkg in "${packages[@]}"; do
    check_pkg "$pkg"
done

printf '\n== Session files ==\n'
check_file /usr/share/wayland-sessions/hyprland.desktop
check_file /usr/share/wayland-sessions/hyprland-uwsm.desktop

printf '\n== User units ==\n'
for unit in "${user_units[@]}"; do
    check_user_unit "$unit"
done

printf '\n== System units ==\n'
check_system_unit sddm.service

printf '\n== Dotfiles ==\n'
check_file "$HOME/.config/hypr"
check_file "$HOME/.config/waybar"
check_file "$HOME/.config/swaync"

printf '\n== Result ==\n'
if [[ "$failures" -eq 0 ]]; then
    echo "Verification passed."
else
    echo "Verification found issues."
    exit 1
fi
