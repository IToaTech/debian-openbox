# debian-openbox
Instalacion / Configuracion de OpenBox en Linux Debian

Conjunto de scripts para instalacion un entorno de escritorio basado en OpenBox.

La instalacion de Linux-Debian debe ser sistema base.

El equipo debe estar conectado a internet, preferentemente desde un dispositivo Ethernet.

Para descargar estos scripts en Linux-Debian, ejecutar los siguientes comandos:

# Actualizacion del sistema base
>_ apt-get update && apt-get upgrade && apt-get dist-upgrade

# Instalar utilerias (wget y unzip)
>_ apt-get install wget unzip

# Crear los directorios
# Ejecutar toda la linea
>_ directorio="/home/scripts"; if [ -d "$directorio" ]; then echo "El directorio existe."; else echo "El directorio no existe. Creándolo..." && mkdir "$directorio"; fi; cd "/home/scripts"

# Descargar scripts
>_wget https://github.com/IToaTech/debian-openbox/archive/refs/heads/main.zip
>_unzip main.zip
>_cd debian-openbox-main
>_chmod +x *.sh

# configurar la conexion WiFi
>_bash ./debian-wifi.sh

