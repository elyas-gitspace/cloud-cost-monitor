**Azure Cloud Monitoring Infrastructure**

                            **Présentation**

Ce projet met en place une infrastructure de monitoring complète sur Azure, incluant :

- Bicep pour créer l'infrastructure Azure
- Une VM Ubuntu avec Azure Monitor Agent (AMA)
- Un Log Analytics Workspace pour centraliser les logs et métriques
- Un système d'alertes custom basé sur un script Bash
- GitHub Actions pour un déploiement automatique (CI/CD)

                        **Architecture de monitoring**

Le système de monitoring inclut :

- **Azure Monitor Agent (AMA)** : collecte les logs et métriques de la VM
- **Data Collection Rules (DCR)** : filtre et dirige les logs spécifiques vers Log Analytics
- **Script de monitoring custom** : surveille CPU, RAM et disque en temps réel
- **Azure Monitor Alert Rules** : détecte et notifie les anomalies via email
- **Cron** : exécute le monitoring toutes les 5 minutes

                        **Structure du projet**

```
azure-monitoring-project/
│
├── .github/
│ └── workflows/
│ └── deploy.yml
│
├── bicep/
│ └── main.bicep
│
├── scripts/
│ ├── deploy.sh
│ └── custom_monitor.sh
│
├── docs/
│ └── mail_alert.png
│
└── README.md
```

