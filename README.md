# Kit de délégation multi-agents pour Claude Code

Workflow exporté du projet Typio : Claude (Opus) orchestre, les autres modèles implémentent et relisent.

| Agent | Appel | Rôle |
|---|---|---|
| Haiku | sous-agent `researcher` | exploration, doc, web |
| Luna | `delegate.mjs luna` | micro-changements |
| Sol | `delegate.mjs sol` | patchs ciblés |
| Sonnet | sous-agent `sonnet-dev` | gros volume, tâches délicates |
| Gemini Flash | `delegate.mjs gemini` | review finale de la feature |

Règles complètes : [.claude/workflow/orchestrator.md](.claude/workflow/orchestrator.md).
Modèles, efforts, délais et skills par agent externe : [.claude/workflow/agents.json](.claude/workflow/agents.json).

## Contenu

- `.claude/workflow/` : règles de l'orchestrateur et configuration des agents externes.
- `.claude/scripts/delegate.mjs` : pont vers Codex (Luna, Sol) et Antigravity (Gemini), ne renvoie que le compte rendu final.
- `.claude/agents/` : sous-agents Claude (`researcher`, `sonnet-dev`).
- `.claude/skills/` : 18 skills (budget, brief, vérification, review, commit, branches…).
- `.claude/settings.json` : autorise `delegate.mjs` sans confirmation.
- `CLAUDE.template.md` : modèle de `CLAUDE.md` avec la section « Configuration du projet ».

## Prérequis

- Claude Code.
- Node.js (pour `delegate.mjs`).
- CLI `codex` (Luna, Sol) et `agy` (Gemini) connectés. Chemins forcés possibles via `CODEX_BIN` et `AGY_BIN`.

## Installation

```bash
./install.sh /chemin/du/projet
```

Le script copie `.claude/` sans écraser l'existant (`--force` pour écraser), crée ou complète
`CLAUDE.md`, et ajoute `.claude/state/` au `.gitignore`. Remplir ensuite la section
« Configuration du projet » de `CLAUDE.md` : commandes de vérification, branches, commits,
zones sensibles. Les skills `verification`, `branching`, `commit` et `security-review` s'y réfèrent.
