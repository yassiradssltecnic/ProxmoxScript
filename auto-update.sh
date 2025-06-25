#!/bin/bash

# Configuración
EMAIL="yassir@adssl.com"
HOSTNAME=$(hostname)
LOGFILE="/var/log/auto-update.log"
NEED_REBOOT=0

{
    echo "========== Actualización iniciada: $(date) =========="

    # Actualizar los repositorios y paquetes
    apt update && apt upgrade -y

    # Verificar si se requiere un reinicio
    if [ -f /var/run/reboot-required ]; then
        echo "Se requiere reinicio del sistema."
        NEED_REBOOT=1
    else
        echo "No se requiere reinicio."
    fi

    echo "========== Actualización completada: $(date) =========="

    # Enviar correo de confirmación
    SUBJECT="[$HOSTNAME] Actualización completada"
    if [ "$NEED_REBOOT" -eq 1 ]; then
        SUBJECT="$SUBJECT - Requiere reinicio"
    fi

    mail -s "$SUBJECT" "$EMAIL" < $LOGFILE

} >> "$LOGFILE" 2>&1

