<div align="center">

# 🛡️ OpenCode Termux Sandbox

### *Безопасная изоляция автономных кодинг-агентов в Android Termux через Alpine Linux (PRoot)*

[![Termux](https://img.shields.io/badge/Termux-Android-000000?style=for-the-badge&logo=termux&logoColor=white)](https://termux.dev/)
[![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-Container-0D597F?style=for-the-badge&logo=alpinelinux&logoColor=white)](https://alpinelinux.org/)
[![OpenCode](https://img.shields.io/badge/OpenCode-AI_Agent-8E75B2?style=for-the-badge&logo=openai&logoColor=white)](https://github.com/opencode-ai)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<br/>

**OpenCode Termux Sandbox** — архитектурное решение и готовый набор скриптов для изолированного запуска автономного AI кодинг-агента [OpenCode](https://github.com/opencode-ai) на смартфонах Android без root-прав.

---

</div>

## 🚨 Проблема: Риски автономных AI-агентов

Современные агенты (OpenCode, Codex, Aider) работают в режиме полной автономности: они сами исследуют репозитории, вызывают shell-команды, устанавливают пакеты и правят код.

В стандартном Termux:
- У Android **нет нативного Docker без root**;
- Агент имеет доступ ко всему каталогу `$HOME`, ключам SSH (`~/.ssh`), токенам и данным карты памяти (`/sdcard`);
- Ошибка модели или галлюцинация (`rm -rf`, бесконечные циклы, перезапись бинарников) может повредить систему Termux или затереть важные данные.

---

## 💡 Решение: Песочница на базе Alpine PRoot-Distro

Мы изолируем агента в легковесный виртуальный контейнер **Alpine Linux** через системный механизм `proot-distro`:

```text
  ┌─────────────────────────────────────────────────────────────┐
  │                 Android Host (Termux)                       │
  │                                                             │
  │   Недоступно агенту:                                        │
  │   ❌ /sdcard (фото, личные файлы)                           │
  │   ❌ ~/.ssh (приватные ключи)                               │
  │   ❌ Системные бинарники Termux ($PREFIX)                   │
  │                                                             │
  │   ┌─────────────────────────────────────────────────────┐   │
  │   │        Alpine Linux Sandbox (PRoot-Distro)          │   │
  │   │                                                     │   │
  │   │   Только изолированные монтирования:                │   │
  │   │   📂 ~/projects ──────► /root/projects              │   │
  │   │   ⚙️ ~/.config/opencode ──► /root/.config/opencode  │   │
  │   │                                                     │   │
  │   │   [OpenCode AI Agent] ◄── Автономная работа         │   │
  │   └─────────────────────────────────────────────────────┘   │
  └─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Быстрый старт

### 1. Автоматическая установка (1 минута)
Клонируйте репозиторий и запустите скрипт развертывания:
```bash
git clone https://github.com/Enigman-Termux-lab/opencode-termux-sandbox.git
cd opencode-termux-sandbox
bash scripts/setup-sandbox.sh
```
Скрипт автоматически установит `proot-distro`, развернет минимальный образ Alpine Linux (~5 МБ), настроит Node.js и установит `opencode-ai`.

### 2. Безопасный запуск
Запускайте агента через безопасную обёртку:
```bash
bash scripts/opencode-safe.sh
```
Агент запустится внутри контейнера, видя только рабочую папку проектов и файл настроек.

---

## 🛠 Удобная интеграция (Алиасы и Шорткаты)

Чтобы вызывать изолированного агента одной буквой из любого места:
```bash
mkdir -p ~/bin
cp scripts/opencode-safe.sh ~/bin/opencode-safe
chmod +x ~/bin/opencode-safe

# Добавьте удобный алиас в ~/.bashrc:
echo "alias oo='opencode-safe'" >> ~/.bashrc
source ~/.bashrc
```
Теперь команда `oo` запускает безопасного агента в текущей рабочей папке!

---

## 📄 Лицензия

Распространяется под лицензией [MIT](LICENSE). Разработано для открытой экосистемы **[Enigman-Termux-lab](https://github.com/Enigman-Termux-lab)**.
