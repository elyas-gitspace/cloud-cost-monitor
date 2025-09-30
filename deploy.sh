#!/usr/bin/env bash
set -ex  # Affiche les commandes + stop en cas d'erreur

echo "=== Début du déploiement Bicep Monitoring ==="

# Variables
RG_NAME="bicep-monitoring-rg"
LOCATION="westeurope"
VM_NAME="elyassvm"
WORKSPACE_NAME="elyassws"
ADMIN_USERNAME="elyas"
SSH_PUBKEY_PATH="$HOME/.ssh/id_rsa.pub"

# Vérifie la clé SSH
if [ ! -f "$SSH_PUBKEY_PATH" ]; then
  echo "ERREUR : clé SSH non trouvée à $SSH_PUBKEY_PATH"
  echo "Crée-la avec : ssh-keygen -t rsa -b 2048"
  exit 1
fi
echo "✅ Clé SSH trouvée : $SSH_PUBKEY_PATH"

# Crée le resource group
echo "Création / vérification du Resource Group : $RG_NAME"
az group create --name "$RG_NAME" --location "$LOCATION"
echo "✅ Resource Group prêt"

# Vérifie la CLI Bicep
echo "Vérification de Bicep CLI"
az bicep version
echo "✅ Bicep est disponible"

# Déploie le template Bicep
echo "Déploiement du template Bicep..."
az deployment group create \
  --resource-group "$RG_NAME" \
  --template-file main.bicep \
  --parameters vmName="$VM_NAME" adminUsername="$ADMIN_USERNAME" workspaceName="$WORKSPACE_NAME" sshPublicKey="$(cat "$SSH_PUBKEY_PATH")"

echo "✅ Déploiement terminé !"
echo "Pour obtenir l'IP publique de la VM :"
echo "az vm show -d -g $RG_NAME -n $VM_NAME --query publicIps -o tsv"

