# CachyOS Intel Hyprland Reinstall Runbook

This runbook is for a fresh `CachyOS` or minimal `Arch` reinstall on Intel graphics, using this repository as the installation source of truth.

## Target profile

- Distro: fresh `CachyOS` or minimal `Arch`
- GPU: Intel integrated graphics
- Login manager: `SDDM`
- Audio: `PipeWire`
- Hyprland config: upstream JaKooLit dots
- Install entrypoint: `./tools/run-cachyos-intel-install.sh`

## Before reinstall

From the current system:

1. Create a `snapper` snapshot and confirm it is boot-recoverable.
2. Export app data you care about: browser profile, SSH keys, GPG keys, secrets, VPN config, input method dictionaries.
3. Save a package baseline for reference:

```bash
pacman -Qqe > ~/pkglist-before-reinstall.txt
```

4. Keep a live USB available in case the new install needs rollback or chroot recovery.

## Fresh OS baseline

Install a minimal system first. Do not start from a full desktop spin.

Required baseline on the new system:

- working network
- `git`
- `base-devel`
- your normal user with sudo
- `snapper` if you want snapshot-based rollback again

Recommended package seed:

```bash
sudo pacman -S --needed git base-devel snapper
```

## Clone and install

From a TTY on the new system:

```bash
cd ~/projects
git clone https://github.com/JaKooLit/Arch-Hyprland
cd Arch-Hyprland
chmod +x tools/run-cachyos-intel-install.sh tools/verify-cachyos-hyprland.sh
./tools/run-cachyos-intel-install.sh
```

What this preset does:

- enables `SDDM` and the extra SDDM theme
- enables `PipeWire`
- enables `Thunar`
- enables `Bluetooth`
- enables `xdg-desktop-portal-hyprland`
- enables upstream JaKooLit dotfiles
- keeps all NVIDIA-specific options off
- keeps `zsh` off so shell migration stays manual

## Manual choices to keep consistent

The preset preselects options, but the installer still uses `whiptail` for confirmation.

Keep these decisions consistent during install:

- if asked for an AUR helper, choose `paru`
- keep `dots` enabled
- keep `SDDM` enabled
- do not turn on any NVIDIA or ROG options
- do not switch on `zsh` unless you explicitly want shell migration now

## First boot checks

After installation:

1. Reboot.
2. Log into the `Hyprland` session from `SDDM`.
3. Open a terminal inside Hyprland and run:

```bash
~/projects/Arch-Hyprland/tools/verify-cachyos-hyprland.sh
```

4. Confirm these behaviors manually:
- audio playback works
- microphone input works
- bluetooth toggles on and can discover devices
- screenshot and clipboard tools work
- screen sharing works in your browser or meeting app
- lock and unlock works
- suspend and resume works

## Known repo-specific impact

- `install-scripts/01-hypr-pkgs.sh` removes some conflicting packages, including `cachyos-hyprland-settings`.
- `install-scripts/pipewire.sh` disables `pulseaudio` user units and enables `pipewire` units.
- `install-scripts/dotfiles-main.sh` clones JaKooLit `Hyprland-Dots` during install.

This is why the recommended path is a fresh OS install, not in-place replacement of an existing tuned desktop.
