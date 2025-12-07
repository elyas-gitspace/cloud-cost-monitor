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

                        **Composants principaux**

Infrastructure Azure (Bicep)

- **VM Ubuntu** : Standard_B1s, 30GB disk
- **Log Analytics Workspace** : Stockage et analyse des logs
- **Virtual Network + Subnet** : Isolation réseau
- **Public IP Address** : Accès SSH à la VM
- **Network Interface** : Connexion réseau de la VM
- **Diagnostic Settings** : Envoi des métriques vers Log Analytics

Script de monitoring

**custom_monitor.sh**
Surveille en temps réel :
- CPU (alerte si > 80%)
- RAM (alerte si > 80%)
- Disk (alerte si > 90%)

Le script utilise `logger` pour envoyer les alertes dans `/var/log/syslog` avec le tag `[CUSTOM_ALERT]`.

Configuration automatique

- **Cron** : Exécute le script toutes les 5 minutes
- **AMA + DCR** : Collecte automatiquement les logs syslog
- **Azure Monitor Alert** : Détecte les logs `[CUSTOM_ALERT]` et envoie des emails

                    **Requête KQL pour les alertes**

```kql
Syslog 
| where Computer == "elyassvm"
| where SyslogMessage contains "[CUSTOM_ALERT]"

                    
                    **Déploiement avec GitHub Actions**

Workflow : .github/workflows/deploy.yml

Il effectue :

- Authentification Azure

- Génération de clé SSH

- Création du Resource Group

- Déploiement du template Bicep

- Configuration des paramètres de déploiement

                    **Pour déployer manuellement**
                    
Configurer les credentials Azure :

bash
az login

Exécuter le script de déploiement :

bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
Se connecter à la VM et configurer le monitoring :

bash
ssh elyas@<VM_IP>
sudo cp scripts/custom_monitor.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/custom_monitor.sh
sudo crontab -e
# Ajouter : */5 * * * * /usr/local/bin/custom_monitor.sh
Installer Azure Monitor Agent (manuellement sur la VM)