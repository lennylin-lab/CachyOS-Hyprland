#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PRESET="$REPO_DIR/presets/cachyos-intel-sddm.sh"

if [[ ! -f "$PRESET" ]]; then
    echo "Preset not found: $PRESET" >&2
    exit 1
fi

if [[ "${XDG_SESSION_TYPE:-}" != "" && "${XDG_SESSION_TYPE:-}" != "tty" ]]; then
    cat <<'EOF'
Run this from a TTY on the fresh system, not from an active desktop session.

Suggested flow:
1. Log into tty2/tty3.
2. cd into the cloned Arch-Hyprland repo.
3. Run: ./tools/run-cachyos-intel-install.sh
EOF
    exit 1
fi

cd "$REPO_DIR"
chmod +x install.sh
exec ./install.sh --preset "$PRESET"
