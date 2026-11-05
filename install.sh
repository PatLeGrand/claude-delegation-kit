#!/usr/bin/env bash
# Installe le kit de délégation dans un projet : ./install.sh /chemin/du/projet
# N'écrase aucun fichier existant (sauf --force).
set -euo pipefail

KIT="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:?usage: install.sh <projet> [--force]}"
FORCE="${2:-}"
[ -d "$TARGET" ] || { echo "Dossier introuvable : $TARGET" >&2; exit 1; }

copy() {
  local rel="$1" dst="$TARGET/$1"
  if [ -e "$dst" ] && [ "$FORCE" != "--force" ]; then
    echo "  ignoré (existe) : $rel"
  else
    mkdir -p "$(dirname "$dst")" && cp "$KIT/$rel" "$dst" && echo "  copié : $rel"
  fi
}

cd "$KIT"
find .claude -type f | sort | while read -r f; do copy "$f"; done

# CLAUDE.md : créé depuis le modèle, ou complété par l'import de l'orchestrateur.
if [ ! -e "$TARGET/CLAUDE.md" ]; then
  cp "$KIT/CLAUDE.template.md" "$TARGET/CLAUDE.md"
  echo "  créé : CLAUDE.md (section « Configuration du projet » à remplir)"
elif ! grep -q '@.claude/workflow/orchestrator.md' "$TARGET/CLAUDE.md"; then
  { printf '@.claude/workflow/orchestrator.md\n\n'; cat "$TARGET/CLAUDE.md"; } > "$TARGET/CLAUDE.md.tmp"
  mv "$TARGET/CLAUDE.md.tmp" "$TARGET/CLAUDE.md"
  echo "  CLAUDE.md : import de l'orchestrateur ajouté ; reprendre la section « Configuration du projet » depuis CLAUDE.template.md"
fi

# État d'exécution de delegate.mjs, à ne pas versionner.
if [ -d "$TARGET/.git" ] && ! grep -qx '.claude/state/' "$TARGET/.gitignore" 2>/dev/null; then
  [ -s "$TARGET/.gitignore" ] && [ -n "$(tail -c1 "$TARGET/.gitignore")" ] && echo >> "$TARGET/.gitignore"
  echo '.claude/state/' >> "$TARGET/.gitignore" && echo "  .gitignore : .claude/state/ ajouté"
fi

echo "Terminé. Vérifier les CLI : node .claude/scripts/delegate.mjs quota"
