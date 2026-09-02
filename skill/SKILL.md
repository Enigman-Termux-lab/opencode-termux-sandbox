---
name: opencode-termux-sandbox
description: Deploy and run OpenCode AI agent in an isolated Alpine PRoot-Distro sandbox on Android Termux without root.
---

# OpenCode Termux Sandbox Skill

Use this skill to deploy, configure, and operate OpenCode AI agent within an isolated container to prevent destructive changes to Android or Termux files.

## Workflow

1. **Setup Environment:** Run `setup-sandbox.sh` to install `proot-distro` and provision Alpine Linux with Node.js and `opencode-ai`.
2. **Directory Isolation:** Only `$HOME/projects` and `$HOME/.config/opencode` are bind-mounted. The host Android `/sdcard`, Termux home, and private keys remain inaccessible.
3. **Execution:** Launch OpenCode via `opencode-safe.sh "$@"` instead of running the host binary directly.
