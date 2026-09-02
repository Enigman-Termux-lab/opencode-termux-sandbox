#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OpenCode Sandbox — Environment Setup Script
# Развертывание изолированного контейнера Alpine Linux в proot-distro
# ==============================================================================
set -euo pipefail

echo "=================================================="
echo "🛡️ Установка изолированной песочницы для OpenCode"
echo "=================================================="

# 1. Проверяем и устанавливаем proot-distro
if ! command -v proot-distro >/dev/null 2>&1; then
    echo "📦 Установка пакета proot-distro в Termux..."
    pkg update -y && pkg install proot-distro -y
fi

# 2. Устанавливаем Alpine Linux (минимальный вес ~5 МБ)
if ! proot-distro list 2>/dev/null | grep -q "alpine (installed)"; then
    echo "🐧 Скачивание и развертывание Alpine Linux..."
    proot-distro install alpine
else
    echo "🟢 Окружение Alpine Linux уже установлено."
fi

# 3. Устанавливаем необходимые зависимости внутри контейнера
echo "⚙️ Настройка зависимостей внутри песочницы (Node.js, Git, Bash)..."
proot-distro login alpine -- bash -c "
    apk update && apk upgrade && \
    apk add --no-cache nodejs npm git bash curl ca-certificates && \
    npm install -g opencode-ai@latest
"

# 4. Создаем рабочие каталоги на хосте
mkdir -p "$HOME/projects"
mkdir -p "$HOME/.config/opencode"

echo ""
echo "✅ Песочница успешно настроена!"
echo "Теперь вы можете запускать изолированного агента скриптом: ./scripts/opencode-safe.sh"
echo "=================================================="
