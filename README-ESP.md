# Guía para Huawei Matebook X Pro hackintosh
 
### Tienes la libertad de ayudar a un estudiante pobre al fondo de la página o [aquí](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/README-ESP.md#ayúdame-por-favor)
 
Esta guía es para instalar macOS en Huawei Matebook X Pro.
 
[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)
 
***RENUNCIA***
 
Este proyecto está todavía en el estado de prueba.
Queda bajo su responsabilidad cualquier problema surgido.
 
## Especificaciones de mi Matebook X Pro:

- CPU: i7-8550U @ 1.8GHz
- 16GB RAM
- Nvidia GTX MX150 / Intel UHD 620
- 3K pantalla @ 3000x2000
- 512 Gb Toshiba SSD (No he probado todavía los SSDs de Liteon)
- USB Wifi: Edimax N150
 
## Lo que funciona:

- Aceleración de Intel UHD 620 gráficos (Ahora estamos usando un platform-id CoffeeLake, cambiaremos al Kabylake gráficos en el futuro)
- Realtek alc256 Audio con VoodooHDA
- Teclado con control de volumen (via VoodooPS2)
- HDMI + Thunderbolt 3 (TB3 por lo menos trabaja como una salida de video, no sé de otras funcionalidades como eGPU)
- Apoyo de la cámara 10.14.0
- Trackpad con nativo gestos via VoodooI2c (se puede utilizar gestos de 3 dedos)
- Pantalla táctil (La utiliza como un trackpad gigante)
- porcentaje de batería (con ACPIBatteryManager)
- Bluetooth (esta en fase beta aún)
- Administración de energía (con CPUFriend y CPUFriendProvider)
- WIFI con USB
 
## Lo que no funciona:

- Modo suspensión (La causa es probablemente el bluetooth kext)
- dGPU (No soporta Nvidia Optimus en MacOS)
- eGPU (no lo he probado)
- Sensor de huellas dactilares
- Tarjeta de WIFI interna
 
## Manos a la obra!
 
### Lo que necesitas:

- Huawei Matebook X Pro (i7 o i5, no he probado macOS en el i5)
- macOS 10.14.0+
- 8GB USB
- USB Wifi externo
- Estación USB C (para conectar a un ratón external)
- Un ratón
 
### BIOS Settings:

- f2 es para prender a BIOS
- f12 para seleccionar el dispositivo de arranque.
- Cualquier versión de BIOS esta bien, pero estoy usando el 1.18
- Restaura los valores por defecto
- Desactive el Secure boot
- No se permite cambiar los valores como DVMT del BIOS de Matebook, no se puede EFI tool.
 
## Pre-instalacion:

Antes de instalar macOS, es una buena idea a hacer una copia de seguridad de tus archivos en Windows.
 
Puedes dejar Windows intacto, pero puede resultar complicado. Lea aca para mas información:
http://www.tonymacx86.com/multi-booting/133940-mavericks-windows-8-same-drive-without-erasing.html
 
## Instalar sin una laptop Mac:
 
1. Descargar [gibMacOS Scripts](https://github.com/corpnewt/gibMacOS)
2. Correr `gibMacOS.bat`
3. Correr `MakeInstall.bat`
4. Copiar los archivos de este repo a la unidad USB.
>  Puedes copiar el driver del WIFI USB
5. Conecte su laptop a internet mediante un cable Ethernet, en caso contrario no podrá instalarlo.
6. Arranca desde el USB y selecciona `"Boot macOS install from OS X Base System"`
7. Cuando se reinicie, seleccione `"Boot macOS from <your_drive_name>"`
 
## Instalar con una laptop Mac:
 
1. Descargue `"Install macOs Catalina"` del App Store
2. Inserte su unidad USB y ejecute los siguientes comandos:
  a. `diskutil list` y verifique el número de su unidad USB (por ejemplo disk2)
  b. `diskutil partitionDisk /dev/disk2 2 MBR FAT32 "CLOVER EFI" 200Mi HFS+J "install_osx" R`, generará los volúmenes correspondientes.
  c. `sudo "/Applications/Install macOS Catalina.app/Contents/Resources/createinstallmedia" --volume  /Volumes/install_osx --nointeraction`, copiara los archivos necesarios para la instalación de macOs.
  d. `sudo diskutil rename "Install macOS Catalina" install_osx`, cambiará el nombre del volumen
3. Copiar la carpeta Clover del repo en el volumen Clover de la unidad USB
4. Arranca desde el USB y selecciona `"Boot macOS install from install_osx"` (no es necesario conexión a internet)
5. Cuando se reinicie, seleccione `"Boot macOS from <your_drive_name>"`
 
## Post-installation:
 
1. Descargue Clover Configurator y monte la unidad EFI
2. Instale el driver del WIFI USB
3. Ejecute `sh -c "$(curl -fsSL https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/onekey_installer.sh)"` en la terminal
4. Reinicie y listo!
 
Ya deberia tener funcionando su Huawei Matebook X Pro con macOs.
 
### Creditos:

- Darren_Pan de Reddit
- midi and Maemo de Discord
- Comunidad Chinese Matebook X Pro Hackintosh
- Comunidad Spanish Matebook X Pro Hackintosh
- A todos los desarrolladores que desarrollaron los kexts utilizados en esta guía.
 
## Ayúdame por favor

Si quieres ayudar un estudiante pobre, seleccione alguno de estos métodos. :)
 
- PayPal:
   https://www.paypal.me/gnodipac886#%20MatebookXPro-hackintosh
- Venmo:
   https://venmo.com/code?user_id=2386577070227456090
 
Códigos QR:
 
| PayPal                                                     | Venmo.                                                     | WeChat                                               |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E5%BE%AE%E4%BF%A1%E6%94%AF%E4%BB%98.jpg) |
 
Buena Suerte!