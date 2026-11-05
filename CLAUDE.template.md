@.claude/workflow/orchestrator.md

# Configuration du projet

<!-- À remplir pour chaque projet : les skills `verification`, `branching`, `commit`
     et `security-review` lisent cette section. -->

- Description : <stack et rôle du projet>.
- Commandes de vérification :
  - lint : `<commande>` ;
  - types : `<commande>` ;
  - tests ciblés : `<commande> <fichier>` ; suite complète : `<commande>` ;
  - build : `<commande>`.
- QA d'une grosse feature : suite complète et build, puis les critères d'acceptation joués dans l'app.
- Branches : `main` stable<, `develop` branche d'intégration>. Une branche courte par tâche, nommée `<type>/<description>`.
- Intégration : PR vers `<branche>`, fusionnée en squash avec l'accord de l'utilisateur.
- Commits et push : autorisés sur la branche de tâche à chaque jalon vérifié, jamais sur `main`, jamais de force-push. Message : `<type>(<scope>): <description>`.
- Zones sensibles (`security-review`) : <auth, sessions, permissions, téléversements…>.
