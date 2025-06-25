#!/bin/bash

# Configuración
EMAIL="yassir@adssl.com"
HOSTNAME=$(hostname)
LOGFILE="/var/log/auto-update.log"
NEED_REBOOT=0
UPDATE_SUCCESS=0

# Ejecutar y guardar la salida en el log
{
    echo "========== Actualización iniciada: $(date) =========="

    if apt update && apt upgrade -y; then
        echo "✅ Actualización completada correctamente."
        UPDATE_SUCCESS=1
    else
        echo "❌ Error durante la actualización."
        UPDATE_SUCCESS=0
    fi

    # Verificar si se requiere un reinicio
    if [ -f /var/run/reboot-required ]; then
        echo "⚠️ Se requiere reinicio del sistema."
        NEED_REBOOT=1
    else
        echo "✅ No se requiere reinicio."
    fi

    echo "========== Fin del proceso: $(date) =========="

} >> "$LOGFILE" 2>&1

# Crear resumen para el correo
if [ "$UPDATE_SUCCESS" -eq 1 ]; then
    STATUS="✅ Actualización completada con éxito"
else
    STATUS="❌ Error durante la actualización"
fi

if [ "$NEED_REBOOT" -eq 1 ]; then
    REBOOT="⚠️ Se requiere reinicio del sistema"
else
    REBOOT="✅ No se requiere reinicio"
fi

# Enviar solo resumen por correo
echo -e "$STATUS\n$REBOOT\n\nHost: $HOSTNAME\nFecha: $(date)" | mail -s "[$HOSTNAME] $STATUS" "$EMAIL"

