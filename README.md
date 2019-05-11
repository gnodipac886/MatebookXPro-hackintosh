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
- Builtin Bluetooth: Intel Wireless Bluetooth 8265

## What works:
- Intel UHD 620 Graphics Acceleration
- Brightness
- Sleep
- Realtek alc256 Audio via AppleALC
- Keyboard with Volume Controls and Brightness controls (via VoodooPS2)
- Camera support up to 10.14.3
- Trackpad and Native Gestures via Custom VoodooI2C
- Touchscreen with multi-touch capabilities (think of it as a large trackpad)
- Battery Percentage
- Bluetooth (Reboot from Widows required - should persist after single reboot)
- Power Management - I'm getting around 8-9 hours.
- Wifi via USB dongle
- Liton SSDs are now supported.
- HDMI 2.0 support, up to theoretically 4K @60Hz. (Only 4K @30 tested due to equipment limitations)

## What doesn't Work:
- dGPU (Nvidia Optimus not supported on MacOS)
- eGPU (not tested)
- Fingerprint Sensor
- Intel Wifi (soldered onto the motherbaord)

## Let's Get Started

### What you need:
- Huawei Matebook X Pro (either i7 or i5 model)
- macOS or OS X downloaded from the Mac App Store
- 8GB USB stick
- External USB Wifi Dongle
- USB C dock (for connecting to external mouse for initial setup)

### BIOS Settings
- f2 is for booting into BIOS
- f12 is for boot override
- Any version of the BIOS is good, but I'm on version 1.26
- Restore Defaults
- Disable Secure boot
- Matebook's BIOS is rewrite protected, EFI tool is useless against this BIOS.

## Pre-Install:
Prior to installing macOS, it is a good idea to backup any important files on Windows.

- You can also leave Windows intact, but it can get tricky. Read [here](http://www.tonymacx86.com/multi-booting/133940-mavericks-windows-8-same-drive-without-erasing.html) for more information: 

- [This](https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/) guide for creating USB and installing using Clover UEFI works well for this laptop: 

- For the installation purposes, please use the HD620 plist that rehabman provides in his guide for your installation USB.

***Set config.plist/Graphics/ig-platform-id=0x12345678 for installation.***

I ended up wiping windows and installing it afterwards, if you do so, fingerprint sensor will stop working, please follow the guide from [this](http://bradshacks.com/matebook-x-pro-fingerprint/) link:

Install macOS according to post 2 of [this](https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/) guide.

## Post Installation

You should now be at your desktop.

Download
- [Clover Configurator Pro](https://github.com/Micky1979/Clover-Configurator-Pro/blob/master/Updates/CCP_v1.4.1.zip?raw=true)
- USB Wi-fi Drivers
- Newest [Clover Bootloader](https://sourceforge.net/projects/cloverefiboot/), and install it to your boot disk

Mount EFI partition if not mounted already

Clone the repository via terminal or download it and swap the CLOVER folder downloaded for the one in your EFI directory.

**IMPORTANT** `BrcmFirmwareRepo.kext` is in `/CLOVER/kexts/Other` from this repository - make sure to move it to `/Library/Extensions`. These kexts will allow bluetooth to persist after a single reboot from Windows.

***Note if you have the i5 version, or any other configurations of the laptop sold exclusively in China***, you should:
- delete the DSDT.aml file in /Volumes/EFI/EFI/CLOVER/ACPI/patched and generate your own via pressing f4 at the clover bootscreen.
- For i5 models: you have to make a custom CPUFriendProvider for Power Management by following [this](https://github.com/PMheart/CPUFriend/blob/master/Instructions.md) guide:
	
### DSDT fixes
Add the VoodooI2C patches (One for the SKL+ one for Windows 10 Patch)
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

# Updates
### 5/1/2019: Most Important Update Yet
- Native brightness is now working
- macOS is able to automatically adjust the brightness accroding to the ambient light sensor
- Native Sleep is now working, not more glitchy screen after computer comes out from sleep, fixed by injecting custom EDID values
- Native graphics: we are now using KBL graphics, we had to change the maximum link rate to HBR in order for the screen to work
- Better audio: speakers are now louder, you can always just use voodooHDA but you will lose headphone detection
- WhatEverGreen updated to version 1.2.8
- VoodooI2C kext updated
- Note* you still need to patch your DSDT for trackpad to work, and brightness keys to work.


### 4/11/2019: New LiteOn Patch
- If you have problems updating to 10.14.4 (seeing a prohibited sign), its likely that the problem is caused by your liteon drive, please replace the following patch in your config.plist before you update.
- I haven't tested this yet since I don't have a LiteOn drive, but this should work theoretically. 
```
      <dict>
        <key>Comment</key>
        <string>IONVMeFamily: Ignore FLBAS bit:4 being set - for Plextor/LiteOn/Hynix</string>
        <key>Disabled</key>
        <false/>
        <key>Name</key>
        <string>IONVMeFamily</string>
        <key>Find</key>
        <data>SBr2wRAPhQ==</data>
        <key>Replace</key>
        <data>SBr2wQAPhQ==</data>
      </dict>
```

### 4/2/2019: Config for Updating/Installing
- Added New config-install/update.plist in CLOVER folder for installing purposes. You may choose this config in the boot screen of Clover: options - configs - config-install/update.plist

### 4/1/2019: 10.14.4 & New Power Management Kexts
- New CPUFriend and CPUFriendProvider kexts for better battery life. (~9 hrs)
- Run the following code if you would like to make a custom version of the power management kexts to your liking, then install the kexts located at your desktop to Clover. [Source](https://github.com/daliansky/XiaoMi-Pro/tree/master/one-key-cpufriend)
```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/daliansky/XiaoMi-Pro/master/one-key-cpufriend/one-key-cpufriend.sh)"

```
- Undervolt the CPU/GPU/Cache via a shell: Place the new "voltageshift" file into your downloads folder and run the "voltageset.command" script to undervolt, and the "voltageinfo.command" to check your results. Furthermore, you can also set custom values to what you would like to undervolt to based on your hardware (i5 vs i7) by editing the script. [Source](https://github.com/daliansky/XiaoMi-Pro/issues/150) 
- WhatEverGreen updated to version 1.2.7
- Lilu updated to version 1.3.5
- New config.plist in CLOVER comes with 10.14.4 graphics patch in kexttopatch (credit gnodipac886)
- New 10.14.4 graphics patch
```
Comment: CFL patch for MateBook X Pro (10.14.4 credit gnodipac886)
Name: AppleIntelCFLGraphicsFramebuffer
Find: <48ff0557 f607008b 96c02500 008a8e95>
Replace: <b8040000 008986bc 25000031 c05dc395>
```
```
    <dict>
        <key>Comment</key>
        <string>CFL patch for MateBook X Pro (10.14.4 credit gnodipac886)</string>
        <key>Find</key>
        <data>SP8FV/YHAIuWwCUAAIqOlQ==</data>
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

### 1/23/2019 : 10.14.3 Update Graphics
- New 10.14.3 graphics patch
```
CFL patch for MateBook X Pro (10.14.3 credit gnodipac886)
Name: AppleIntelCFLGraphicsFramebuffer
Find: <48ff0589 4d07008b 96c02500 008a8e95>
Replace: <b8040000 008986bc 25000031 c05dc395>
```
```
			<dict>
				<key>Comment</key>
				<string>CFL patch for MateBook X Pro (10.14.3 credit gnodipac886)</string>
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
### 1/21/2019
- New Whatevergreen replaced old custom version
- Lilu updated
- New Applealc to support native audio codec
- Custom version of I2C trackpad kexts for better support
- Added KBL and SKL config.plists for people who are interested to help out. Main issue: Blackscreen/ internal screen not recognized
- config.plist minor fixes

# Credits:
- Darren_Pan on reddit
- midi and Maemo on discord
- Chinese Matebook X Pro Hackintosh community
- Spanish Matebook X Pro Hackintosh community
- All the developers who developed the kexts used in this guide.

# Help a broke student out:
- [PayPal](https://www.paypal.me/gnodipac)
- [Venmo](https://venmo.com/code?user_id=2386577070227456090)
	
QR Codes:

| PayPal                                                     | Venmo.                                                     | WeChat                                               | 支付宝                                              |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E5%BE%AE%E4%BF%A1%E6%94%AF%E4%BB%98.jpg) | ![支付宝_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E6%94%AF%E4%BB%98%E5%AE%9D.jpg) |

Good Luck!
