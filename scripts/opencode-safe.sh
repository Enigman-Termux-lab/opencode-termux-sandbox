#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OpenCode Sandbox — Safe Isolated Wrapper
# Запуск OpenCode внутри Alpine-песочницы с изолированным доступом к FS
# ==============================================================================
set -euo pipefail

PROJECTS_DIR="$HOME/projects"
CONFIG_DIR="$HOME/.config/opencode"

mkdir -p "$PROJECTS_DIR" "$CONFIG_DIR"

# Умное определение рабочей директории внутри песочницы
if [[ "$PWD" == "$HOME" ]]; then
    GUEST_DIR="/root/projects"
elif [[ "$PWD" == "$HOME/projects"* ]]; then
    REL_PATH="${PWD#$HOME/projects}"
    GUEST_DIR="/root/projects${REL_PATH}"
else
    GUEST_DIR="/root/projects"
fi

# Запуск агента внутри изолированного Alpine контейнера.
# Доступны ТОЛЬКО ~/projects и ~/.config/opencode.
# Системные папки Android, приватные ключи SSH и данные Termux полностью отрезаны.
exec proot-distro login alpine     --shared-tmp     --bind "$PROJECTS_DIR:/root/projects"     --bind "$CONFIG_DIR:/root/.config/opencode"     -- bash -c "cd "$GUEST_DIR" 2>/dev/null || cd /root/projects; opencode "\$@""
