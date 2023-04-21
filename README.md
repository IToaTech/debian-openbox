# debian-openbox
Instalacion / Configuracion de OpenBox en Linux Debian

Conjunto de scripts para instalacion un entorno de escritorio basado en OpenBox.


La instalacion de Linux-Debian debe ser sistema base.

El equipo debe estar conectado a internet, preferentemente desde un dispositivo Ethernet.

Para descargar estos scripts en Linux-Debian, ejecutar los siguientes comandos:

# Actualizacion del sistema base
>_apt-get update
>_apt-get upgrade
>_apt-get dist-upgrade

>_apt-get install wget unzip

>_cd /home/
>_mkdir /home/scripts
>_cd /home/scripts

>_wget https://github.com/IToaTech/debian-openbox/archive/refs/heads/main.zip
>_unzip main.zip
>_cd debian-openbox-main
>_chmod +x *.sh

# configurar la conexion WiFi
>_bash ./debian-wifi.sh

