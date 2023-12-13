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

# Script git-hub (crear)
>_ nano /home/scripts/debian-openbox-scripts-update.sh

# Pegar las siguientes lineas
rm main.*
url_git_main="https://github.com/IToaTech/debian-openbox/archive/refs/heads/main.zip"
wget "$url_git_main"
unzip main.zip
chmod +x /home/scripts/debian-openbox-main/*.sh

# Script git-hub (permiso ejecucion)
>_ chmod +x /home/scripts/debian-openbox-scripts-update.sh

# Script git-hub (actualizar archivos git-hub)
# suponiendo que estamos en el directorio "/home/scripts"
>_ sh ./debian-openbox-scripts-update.sh

# Script git-hub (configurar la conexion WiFi)
# suponiendo que estamos en el directorio "/home/scripts"
>_ bash ./debian-openbox-main/debian-wifi.sh

