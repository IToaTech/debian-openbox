#!/bin/bash

# Definimos colores, primer plano
PNegro='\033[30m'		# 1
PRojo='\033[31m'		# 2
PVerde='\033[32m'		# 3
PNaranja='\033[33m'	# 4
PAzul='\033[34m'		# 5
PMagenta='\033[35m'	# 6
PDrkMagn='\033[45m'
PCian='\033[36m'		# 7
PGris='\033[37m'		# 8
PBlanco='\e[37m'		# 9
NC='\033[39m'

# Colores de fondo, video inverso o segundo plano
IGris='\033[100m'		# 8 Gris oscuro
IRojo='\033[101m'		# 7 Luz roja
IVerde='\033[102m'		# 6 Verde claro
INaranja='\033[103m'		# 5 Amarillo
IAzul='\033[104m'		# 4 Azul claro
IMagenta='\033[105m'		# 3 Morado claro
ICian='\033[106m'		# 2 Verde azulado
IBlanco='\033[107m'		# 1 Blanco
INC='\033[40m'
clear

# Funcion
function fn_exit() {
   echo
   printf "${PMagenta}"
   echo "__________________________________________________"
   read -p "¿Continuar? [S,N]: " input
   if [[ $input == "S" || $input == "s"  || $input == "Y" || $input == "y" ]]; then
      echo "Script continua ejecucion..."
      echo "__________________________________________________"
      echo
      printf "${NC}${INC}"
   else
      echo "Script cancela ejecucion...";
      echo
      printf "${NC}${INC}"
      exit;
   fi
}

# Color reset
printf "${NC}${INC}"

# Instrucciones para ejecutar este script
echo
echo "Instrucciones:"
echo "El equipo solo debe tener instalado un sistema 'Debian Base'"
echo "Este script se ejecuta >_bash <archivo_script.sh>"
echo
echo "Este script esta configurado para ejecutarse en una shell-bash"
echo "Este script sirve de apoyo para configurar la conexion de WiFi mediante la linea de comandos CLI"
echo "===================================================================================================="
echo

# Color Titulo
printf "${PNegro}${IBlanco}%s"
echo "1. Verificar que el entorno es apropiado para la ejecucion"
printf "${NC}${INC}"
echo "----------------------------------------------------------------------"

# No aceptar variables sin registro
set -o nounset

# Si no se esta ejecutando en una terminal, salir del script
[[ -t 0 && -t 1 && -t 2 ]] || { echo "$0: Este script debe ejecutarse desde una terminal" >&2; exit 1; }

# Si se ejecuta en un TTY, deshabilita que la pantalla obscurezca
[[ "$TERM" = "linux" ]] && setterm -blank 0

echo "Script se ejecuta en un terminal: $TERM (oscurecimiento de pantalla desactivado)"

# Funcion Salir
fn_exit

# Instalar paquetes
echo
printf "${PNegro}${IBlanco}"
echo "2. Instalar paquetes necesarios"
printf "${NC}${INC}"
echo "----------------------------------------------------------------------"
var_apps="network-manager net-tools wireless-tools rfkill"
echo "Se instalaran los paquetes: " $var_apps
echo
apt-get install $var_apps
#wifi-qr

# Funcion Salir
fn_exit

echo
printf "${PNegro}${IBlanco}"
echo "3. Identificar dispositivos de red PCI (ethernet y wireless)"
printf "${NC}${INC}"
echo "----------------------------------------------------------------------"
lspci -k | grep -EA3 "Network|Wireless"

# Funcion Salir
fn_exit

echo
printf "${PNegro}${IBlanco}"
echo "4. Identificar dispositivos de red conectados por usb (ethernet y wireless)"
printf "${NC}${INC}"
echo "----------------------------------------------------------------------"
lsusb | grep -EA3 "Network|Wireless"

# Funcion Salir
fn_exit

echo
printf "${PNegro}${IBlanco}"
echo "5. Identificar drivers de red incorporados al kernel"
printf "${NC}${INC}"
echo "----------------------------------------------------------------------"
dmesg | grep -EA3 "Network|Wireless|wlan"

# Funcion Salir
fn_exit

echo
echo "6. Checar el nombre de la interface de red Wireless"
echo "----------------------------------------------------------------------"
ip link show
echo "Escribir el nombre de la interface de red Wireless:"
read var_DevWiFi

# Funcion Salir
fn_exit

echo
echo "7. Verificar bloqueo de dispositivos de red"
echo "----------------------------------------------------------------------"
/sbin/rfkill list
# Falta: comprobacion de dispositovs bloqueados

# Funcion Salir
fn_exit

echo
echo "8. Instalacion de drivers de dispositivos de red"
echo "----------------------------------------------------------------------"
# Falta: Preguntar si hay algun disposito que no se reconoce
# Falta: identificar marca y modelo
# Falta: instrucciones de instalacion de drivers segun el modelo


echo
echo "9. Verificar si "nmcli" tiene control de dispositivos de red wireless"
echo "----------------------------------------------------------------------"
nmcli dev show $var_DevWiFi

echo "Si la configuracion aparece como 'unmanaged', es casi seguro que no existen archivos de configuracion:"
ls /etc/NetworkManager/system-connections

# Funcion Salir
fn_exit

echo
echo "10. Si la configuracion anterior esta como 'unmanaged', se va ejecutar la siguiente orden:"
echo "----------------------------------------------------------------------"
nmcli dev set $var_DevWiFi managed yes

# Funcion Salir
fn_exit

echo
echo "12. Escanear las redes WiFi - nmcli"
echo "----------------------------------------------------------------------"
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

echo
echo "13. Escanear las redes WiFi - iwlist"
echo "----------------------------------------------------------------------"
iwlist scan $var_DevWiFi | grep -e "ESSID" -e "IEEE"
echo "Escriba el nombre de la Red WiFi (Presione ENTER)"
read var_WiFiESSID
echo "Escriba el nombre de la seguridad de la Red WiFi (Presione ENTER)"
read var_WiFiSec

echo "Los datos escritos son los siguientes (Presione ENTER)"
echo "Red WiFi: " $var_WiFiESSID " - Seguridad: " $var_WiFiSec
