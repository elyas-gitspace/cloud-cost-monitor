# File: README.md
```markdown
# Projet Bicep Monitoring


Ce projet déploie :
- Une VM Ubuntu Linux (Standard_B1s)
- Un Log Analytics Workspace
- Des diagnostics connectés pour envoyer les métriques


## Étapes
1. Modifier les variables en haut de `deploy.sh`
2. Exécuter `chmod +x deploy.sh && ./deploy.sh`
3. Récupérer l'IP publique et se connecter : `ssh azureuser@<IP>`
4. Exécuter `setup-vm.sh` pour lancer des tests de charge
5. Vérifier dans le portail Azure que les métriques montent et configurer une alerte CPU > 80%
6. Nettoyer avec `cleanup.sh`
```

# Test github actions