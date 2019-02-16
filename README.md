# Matebook X Pro Hackintosh
This is the guide to install macOS onto the Huawei Matebook X Pro.

### Feel free to help a broke student out at the bottom of the page. :)

[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)

***DISCLAIMER***
The project is still in its beta/testing state.
Proceed at your own risk, I shall not take responsibility for any damages caused.

## My Matebook X Pro's Hardware Configuration:
- CPU: i7-8550U @ 1.8GHz
- 16GB RAM
- Nvidia GTX MX 150 / Intel UHD 620
- 3K display @ 3000x2000
- 512 Gb Toshiba SSD
- USB Wifi: Edimax N150

## What works:
- Intel UHD 620 Graphics Acceleration (we are using a CoffeeLake platform-id for now, will try to 	switch to native Kabylake graphics)
- Realtek alc256 Audio via AppleALC
- Keyboard with Volume Controls and Brightness controls (via VoodooPS2)
- Camera support up to 10.14.3
- Trackpad and Native Gestures via Custom VoodooI2C
- Touchscreen with multi-touch capabilities (think of it as a large trackpad)
- Battery Percentage
- Bluetooth (Reboot from Widows required)
- Power Management (via CPUFriend and CPUFriendProvider, CPU idles at 1.2Ghz though Windows idles 	at 0.8Ghz, needs improvement)(kext taken from TheDarkVoid's Dell XPS 9360 guide)
- Wifi via USB dongle
- Liton SSDs are now supported.
- HDMI 2.0 support, up to theoretically 4K @60Hz. (Only 4K @30 tested due to equipment limitations)

## What doesn't Work:
- Brightness and Sleep (Likely due to spoofing Coffeelake Graphics)
- dGPU (Nvidia Optimus not supported on MacOS)
- eGPU (not tested)
- Fingerprint Sensor
- Intel Wifi (soldered onto the motherbaord)

## Let's Get Started

### What you need:
- Huawei Matebook X Pro (either i7 or i5 model, though i5 model has not been tested)
- macOS or OS X downloaded from the Mac App Store
- 8GB USB stick
- External USB Wifi Dongle
- USB C dock (for connecting to external mouse for initial setup)

### BIOS Settings
- f2 is for booting into BIOS
- f12 is for boot override
- Any version of the BIOS is good, but I'm version 1.18
- Restore Defaults
- Disable Secure boot
- Matebook's BIOS is rewrite protected, EFI tool is useless against this BIOS.

## Pre-Install:
Prior to installing macOS, it is a good idea to backup any important files on Windows.

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

## Post Installation

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
	
### DSDT fixes
Add the following code to your DSDT.aml to fix brightness keys.
```	
into method label _Q0A replace_content
begin
// Brightness Down\n
    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)\n
end;
into method label _Q0B replace_content
begin
// Brightness Up\n
    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)\n
end;
```
Reboot

You should have a half functioning Matebook X Pro Hackintosh by now. 

Known Problems and Partial Solutions:
- Brightness not working: download brightness slider from the App Store, it doesn't change the actual 		brightness, but it pleases the eye since it changes the white spot level or something along 		those lines.
	https://itunes.apple.com/us/app/brightness-slider/id456624497?mt=12
- Sleep doesn't work: after waking from a sleep (closing the lid), your computer will wake and you will 	see a graphics glitch. This should be due to Coffeelake spoofing. We are trying to fix this. 
- Bluetooth: you will need a copy of 10.13.6's IOBluetoothFamily.kext and install it to S/L/E via 		kextbeast.

# Updates

### 1/21/2019
- New Whatevergreen replaced old custom version
- Lilu updated
- New Applealc to support native audio codec
- Custom version of I2C trackpad kexts for better support
- Added KBL and SKL config.plists for people who are interested to help out. Main issue: Blackscreen/ internal screen not recognized
- config.plist minor fixes

### 1/23/2019 : 10.14.3 Update Graphics
- New 10.14.3 graphics patch
```
Comment: CFL patch for MateBook X Pro
Name: AppleIntelCFLGraphicsFramebuffer
Find: <48ff0589 4d07008b 96c02500 008a8e95>
Replace: <b8040000 008986bc 25000031 c05dc395>
```
```
			<dict>
				<key>Comment</key>
				<string>CFL patch for MateBook X Pro</string>
				<key>Find</key>
				<data>SP8FiU0HAIuWwCUAAIqOlQ==</data>
				<key>Name</key>
				<string>AppleIntelCFLGraphicsFramebuffer</string>
				<key>Replace</key>
				<data>uAQAAACJhrwlAAAxwF3DlQ==</data>
				<key>Disabled</key>
				<false/>
			</dict>
```
### 2/1/2019 : 10.14.3 
- New Virtural SMC replacing FakeSMC
- Added support for 4K video output with HDMI audio support
- Added tools.zip for editing system files such as config.plist or DSDT
- Support for firevault2 (In theory, never tested)
- Added vanilla 10.14.3 framebuffer graphics kext, if you have replaced the kext before with a custom version, please swap it out in /System/Library/Extension and then use kextutility in tools.zip to rebuild permissions then reboot with 10.14.3 config.plist.
- Added "Configs" for past config.plists and plists for KBL or SKL graphics (NEED HELP)
- Other tweaks to CLOVER folder to support VituralSMC kext.
- Updated NoTouchID.kext to newest versions for Mojave support which elimates any lags when promted for user password
- Remember to apply brightness key patches to you DSDT.aml so you can play with them for no reason
- New config.plist in CLOVER comes with 10.14.3 graphics patch in kexttopatch (credit gnodipac886)
- Reports of Thunderbolt eGPU was able to work when booted with eGPU plugged in, no hotplug support yet
- Support for Liteon SSDs confirmed with new config.plist in CLOVER and in Configs folder

# Credits:
- Darren_Pan on reddit
- midi and Maemo on discord
- Chinese Matebook X Pro Hackintosh community
- Spanish Matebook X Pro Hackintosh community
- All the developers who developed the kexts used in this guide.

# Help a broke student out:
- PayPal:
	https://www.paypal.me/gnodipac886#%20MatebookXPro-hackintosh
- Venmo:
	https://venmo.com/code?user_id=2386577070227456090
	
QR Codes:

| PayPal                                                     | Venmo.                                                     | WeChat                                               | 支付宝                                              |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E5%BE%AE%E4%BF%A1%E6%94%AF%E4%BB%98.jpg) | ![支付宝_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E6%94%AF%E4%BB%98%E5%AE%9D.jpg) |

Good Luck!
