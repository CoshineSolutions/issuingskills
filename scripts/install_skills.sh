#!/usr/bin/env bash
# Install Coshine Skills into locations discoverable by common AI dev tools.
# Creates idempotent symlinks. Existing symlinks are replaced; existing real
# directories are left untouched (script refuses to overwrite them).
#
# Supported tools out of the box:
#   - Claude Code       → ~/.claude/skills/<name>/
#   - Gemini CLI        → ~/.agents/skills/<name>/   (shared standard)
#   - OpenAI Codex CLI  → ~/.agents/skills/<name>/   (shared standard)
#
# Flags:
#   --claude-only   only install to ~/.claude/skills/
#   --agents-only   only install to ~/.agents/skills/
#   (no flag)       install to both

set -euo pipefail

mode="both"
for arg in "$@"; do
    case "$arg" in
        --claude-only) mode="claude" ;;
        --agents-only) mode="agents" ;;
        -h|--help)
            awk 'NR>1 && /^#/ { sub(/^# ?/, ""); print; next } NR>1 { exit }' "$0"
            exit 0
            ;;
        *) echo "unknown flag: $arg" >&2; exit 2 ;;
    esac
done

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# Skills live inside the plugin dir now (Claude Code marketplace layout).
REPO_SKILLS="$REPO_ROOT/plugins/coshine-card-issuing/skills"

install_into() {
    local target_dir="$1"
    mkdir -p "$target_dir"
    for src in "$REPO_SKILLS"/*/; do
        local name dst
        name="$(basename "$src")"
        dst="$target_dir/$name"

        if [[ -L "$dst" ]]; then
            rm "$dst"
        elif [[ -e "$dst" ]]; then
            echo "ERROR: $dst exists and is not a symlink; refusing to overwrite." >&2
            exit 1
        fi

        ln -s "$src" "$dst"
        echo "installed: $dst -> $src"
    done
}

case "$mode" in
    claude)
        install_into "$HOME/.claude/skills"
        echo
        echo "Done. Restart Claude Code to pick up the skills."
        ;;
    agents)
        install_into "$HOME/.agents/skills"
        echo
        echo "Done. Restart Gemini CLI / Codex CLI to pick up the skills."
        ;;
    both)
        install_into "$HOME/.claude/skills"
        echo
        install_into "$HOME/.agents/skills"
        echo
        echo "Done. Restart Claude Code / Gemini CLI / Codex CLI to pick up the skills."
        ;;
esac
