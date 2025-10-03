#!/bin/bash

# Script de monitoring custom
LOG_FILE="/var/log/custom_monitor.log"

# Récupérer l'utilisation CPU
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU=$(printf "%.2f" "$CPU")

# Récupérer l'utilisation RAM
MEM=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100.0}')

# Récupérer l'utilisation disque racine
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Log dans un fichier custom
echo "$(date '+%Y-%m-%d %H:%M:%S') | CPU=${CPU}% RAM=${MEM}% DISK=${DISK}%" >> "$LOG_FILE"

# Déclencheurs
if (( $(echo "$CPU > 80" | bc -l) )); then
  logger "[CUSTOM_ALERT] CPU HIGH: ${CPU}%"
fi

if (( $(echo "$MEM > 80" | bc -l) )); then
  logger "[CUSTOM_ALERT] MEMORY HIGH: ${MEM}%"
fi

if [ "$DISK" -gt 90 ]; then
  logger "[CUSTOM_ALERT] DISK USAGE HIGH: ${DISK}%"
fi