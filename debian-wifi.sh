#!/bin/bash

# Instrucciones para ejecutar este script
echo
echo "Instrucciones:"
echo "Este script se ejecuta >_bash <archivo_script.sh>"
echo "El equipo solo debe tener instalado un sistema 'Debian Base'"
echo
echo "Este script esta configurado para ejecutarse en una shell-bash"
echo "Este script sirve de apoyo para configurar la conexion de WiFi mediante la linea de comandos CLI"
echo "===================================================================================================="
echo
echo "1. Verificar que el entorno es apropiado para la ejecucion"
echo "----------------------------------------------------"

# No aceptar variables sin registro
set -o nounset

# Si no se esta ejecutando en una terminal, salir del script
[[ -t 0 && -t 1 && -t 2 ]] || { echo "$0: Este script debe ejecutarse desde una terminal" >&2; exit 1; }
echo "Ejecutando en un terminal"

# Si se ejecuta en un TTY, deshabilita que la pantalla obscurezca
[[ "$TERM" = "linux" ]] && setterm -blank 0
echo "Ejecutando en un terminal : $TERM (oscurecimiento de pantalla desactivado)"


echo
echo "2. Instalar paquetes necesarios"
echo "----------------------------------------------------"
apt-get install wifi-qr rfkill


echo
echo "3. Identificar dispositivos de red PCI (ethernet y wireless)"
echo "----------------------------------------------------"
lspci -k | grep -EA3 "Network|Wireless"

echo
echo "4. Identificar dispositivos de red conectados por usb (ethernet y wireless)"
echo "----------------------------------------------------"
lsusb | grep -EA3 "Network|Wireless"

echo
echo "5. Checar el nombre de la interface de red Wireless"
echo "----------------------------------------------------"
ip link show

echo
echo "6.Verificar que el dispositivo no este bloqueado"
echo "----------------------------------------------------"
/sbin/rfkill list


echo
echo "7. Velocidad de las tarjetas de Red activas (root)"
echo "----------------------------------------------------"
dmesg | grep "flow"
dmesg | grep "NIC"


echo
echo "8. Escanear las redes WiFi"
echo "----------------------------------------------------"
nmcli -f ALL -t dev wifi | awk -F ":" 'BEGIN {counter=1;}
                                             { array[counter,0]=$2;
                                               array[counter,1]=$16;
                                               print counter " | " array[counter,0] " | " array[counter,1];
                                               counter++; }
                                       END   { print "\nTotal Redes : " counter-1;
                                               print "\n1) Seleccione una red [0 Salir ]:";
                                               getline var_Opcion <"/dev/tty";
                                               print "\n1) Seleccionaste la red: " array[var_Opcion,0];
                                               print "La seguridad es tipo: " array[var_Opcion,1]; }'

