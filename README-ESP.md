# Guía para Huawei Matebook X Pro hackintosh

### Tienes la libertad de ayudar a un estudiante pobre al fondo de la página o [aquí](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/README-ESP.md#ayúdame-por-favor)

Esta guía es para instalar macOS en Huawei Matebook X Pro.

[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)

***RENUNCIA***

Este proyecto está todavia en el estado de prueba.
Queda bajo su resposabilidad cualquier problema surgido.

## Especificaciones de mi Matebook X Pro :
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
- HDMI + Thunderbolt 3 (TB3 pro lo menos trabaja como una salida de video, No sé de otras funcionalidades como eGPU)
- Apoyo de la cámara 10.14.0
- Trackpad con nativo gestos via VoodooI2c (se puede utilizar gestos de 3 dedos)
- Pantalla táctil (La utilíza como un trackpad grande)
- porcentaje de batería (con ACPIBatteryManager)
- Bluetooth (esta en fase beta aun)
- Administración de energía (con CPUFriend y CPUFriendProvider)
- WIFI con USB

## Lo que no funciona:
- Brillo y modo suspensión (La causa es probablemente Coffeelake)
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

### BIOS Settings
- f2 es para prender a BIOS
- f12 para seleccionar el dispositivo de arranque.
- Cualquier versión de BIOS esta bien, pero estoy usando el 1.18
- Restaura los valores por defecto
- Desactiva Secure boot
- No se permite cambiar los valores como DVMT del BIOS de Matebook, no se puede EFI tool.

## Pre-instalacion:
Antes de instalar macOS, es una buena idea a hacer una copia de seguridad de tus archivos en Windows.

Puedes dejar Windows intacto, pero puede resultar complicado. Lea aca para mas informacion: 
http://www.tonymacx86.com/multi-booting/133940-mavericks-windows-8-same-drive-without-erasing.html

## Instalar sin una laptop Mac

1. Descargara [gibMacOS Scripts](https://github.com/corpnewt/gibMacOS)
2. Correr `gibMacOS.bat`
3. Correr `MakeInstall.bat`
4. Copiar los archivos de este repo a la unidad USB.
>  Puedes copiar el driver del WIFI USB
5. Conecte su laptop a internet mediante un cable Ethernet, en caso contrario no podra instalarlo.
6. Arranca desde el USB y selecciona `"Boot macOS install from OS X Base System"`
7. Cuando se reinicie, seleccione `"Boot macOS from <your_drive_name>"`

## Instalar con una laptop Mac

1. Descargue `"Install macOs Catalina"` del AppStore
2. Inserte su unidad USB y ejecute los siguientes comandos:
   a. `diskutil list` y verifique el numero de su unidad USB (por ejemplo disk2)
   b. `diskutil partitionDisk /dev/disk2 2 MBR FAT32 "CLOVER EFI" 200Mi HFS+J "install_osx" R`, generara los volumenes correspondientes.
   c. `sudo "/Applications/Install macOS Catalina.app/Contents/Resources/createinstallmedia" --volume  /Volumes/install_osx --nointeraction`, copiara los archivos necesarios para la instalacion de macOs.
   d. `sudo diskutil rename "Install macOS Catalina" install_osx`, cambiara el nombre del volumen
3. Copiar la carpeta Clover del repo en el volumen Clover de la unidad USB
4. Arranca desde el USB y selecciona `"Boot macOS install from install_osx"` (no es necesario conexion a internet)
5. Cuando se reinicie, seleccione `"Boot macOS from <your_drive_name>"`

Post Installation

You should now be at your desktop.

Download
- Clover Configurator Pro
	https://github.com/Micky1979/Clover-Configurator-Pro/blob/master/Updates/CCP_v1.4.1.zip?raw=true
- USB Wi-fi Drivers
- Newest Clover Bootloader, and install it to your boot disk
	https://sourceforge.net/projects/cloverefiboot/

Mount EFI partition if not mounted already

Clone the repository via terminal or download it and swap the CLOVER folder downloaded for the one in your EFI directory.

***Note if you have the i5 version, or any other configurations of the laptop sold exclusively in China***, you should:
- delete the DSDT.aml file in /Volumes/EFI/EFI/CLOVER/ACPI/patched and generate your own via pressing f4 	at the clover bootscreen.
- For i5 models: you have to make a custom CPUFriendProvider for Power Management by following this 		guide:
	https://github.com/PMheart/CPUFriend/blob/master/Instructions.md

Reboot

You should have a half functioning Matebook X Pro Hackintosh by now. 

Known Problems and Partial Solutions:
- Brightness not working: download brightness slider from the App Store, it doesn't change the actual 		brightness, but it pleases the eye since it changes the white spot level or something along 		those lines.
	https://itunes.apple.com/us/app/brightness-slider/id456624497?mt=12
- Sleep doesn't work: after waking from a sleep (closing the lid), your computer will wake and you will 	see a graphics glitch. This should be due to Coffeelake spoofing. We are trying to fix this. 
- Bluetooth: you will need a copy of 10.13.6's IOBluetoothFamily.kext and install it to S/L/E via 		kextbeast.

### Credits:
- Darren_Pan on reddit
- midi and Maemo on discord
- Chinese Matebook X Pro Hackintosh community
- Spanish Matebook X Pro Hackintosh community
- All the developers who developed the kexts used in this guide.

## Ayúdame por favor
Si quieres ayudar un estudiante más pobre, me debes ayudar. :)

- PayPal:
    https://www.paypal.me/gnodipac886#%20MatebookXPro-hackintosh
- Venmo:
    https://venmo.com/code?user_id=2386577070227456090

Códigos QR:

| PayPal                                                     | Venmo.                                                     | WeChat                                               |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E5%BE%AE%E4%BF%A1%E6%94%AF%E4%BB%98.jpg) |

Buena Suerte!
