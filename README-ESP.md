# Guía para Huawei Matebook X Pro hackintosh

Este guía es para instalar macOS al Huawei Matebook X Pro.

Estoy traduciendo la guía al Español

Por favor ten paciencia

### Tienes el libertad a ayudar a un estudiante pobre al fondo de la página

[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)

***RENUNCIA***

Este proyecto está todavia en el estado de prueba.
Continúa bajo su cuenta y riesgo.

## La Configuración de mi Matebook X Pro :
- CPU: i7-8550U @ 1.8GHz
- 16GB RAM
- Nvidia GTX MX150 / Intel UHD 620
- 3K pantalla @ 3000x2000
- 512 Gb Toshiba SSD (No he probado todavía los SSDs de Liteon)
- USB Wifi: Edimax N150

## Los que funciona:
- Aceleración de Intel UHD 620 gráficos (Ahora estamos usando un platform-id CoffeeLake, cambiaremos al Kabylake gráficos en el futuro)
- Realtek alc256 Audio con VoodooHDA
- Teclado con control de volumen (via VoodooPS2)
- HDMI + Thunderbolt 3 (TB3 pro lo menos trabaja como una salida de video, No sé de otras funcionalidades como eGPU)
- Apoyo de la cámara 10.14.0
- Trackpad con nativo gestos via VoodooI2c (usa gestos de cinco dedos como una substit)
- Pantalla táctil (La utilíza como un trackpad grande)
- porcentaje de batería (con ACPIBatteryManager)
- Bluetooth (Not es estable, tiene que reincinar el ordenador desde Windows a macOS)
- administración de energía (con CPUFriend and CPUFriendProvider)
- Wifi con USB

## Los que no funciona:
- Brillo y modo suspensión (La causa es probablemente Coffeelake gráficos)
- dGPU (No se apoya Nvidia Optimus en MacOS)
- eGPU (no he probado)
- sensor de huellas dactilares
- Interno Intel Wifi

## Vamonos!

### Lo que necesitas:
- Huawei Matebook X Pro (i7 o i5, no he probado macOS en el i5)
- macOS 10.14.0+
- 8GB USB
- USB Wifi externo
- Estación USB C (para conectar a un ratón external)
- un ratón

### BIOS Settings
- f2 es para prender a BIOS
- f12 es para cambiar el aparato de boot
- Qualquier versión de BIOS es bueno, pero estoy usando el 1.18
- Restaura el valor de defecto
- Apaga Secure boot
- No se permite cambiar los valores como DVMT del BIOS de Matebook, no se puede EFI tool.

## Pre-Instalar:
Antes de instalar macOS, es una buena idea a hacer una copia de seguridad de tus archivos en Windows.

You can also leave Windows intact, but it can get tricky. Read here for more information: 
http://www.tonymacx86.com/multi-booting/133940-mavericks-windows-8-same-drive-without-erasing.html

This guide for creating USB and installing using Clover UEFI works well for this laptop: 
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

For the installation purposes, please use the HD620 plist that rehabman provides in his guide for your installation USB.

***Set config.plist/Graphics/ig-platform-id=0x12345678 for installation.***

I ended up wiping windows and installing it afterwards, if you do so, fingerprint sensor will stop working, please follow the guide from this link:
http://bradshacks.com/matebook-x-pro-fingerprint/

Install macOS according to post 2 of the guide:
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

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

### Help a broke student out:
- PayPal:
	https://www.paypal.me/gnodipac886#%20MatebookXPro-hackintosh
- Venmo:
	https://venmo.com/code?user_id=2386577070227456090
	
QR Codes:

| PayPal                                                     | Venmo.                                                     | WeChat                                               |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/WeChat.jpg) |

Good Luck!

Si quieres ayudar un estudiante más pobre, me debes ayudar. :)

- PayPal:
	https://www.paypal.me/gnodipac886#%20MatebookXPro-hackintosh
- Venmo:
	https://venmo.com/code?user_id=2386577070227456090
	
Códigos QR:

| PayPal                                                     | Venmo.                                                     | WeChat                                               |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/WeChat.jpg) |
