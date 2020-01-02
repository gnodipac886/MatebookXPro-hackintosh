# Matebook X Pro Hackintosh
This is the guide to install macOS onto the Huawei Matebook X Pro.

### Click [here](https://github.com/gnodipac886/MatebookXPro-hackintosh#help-a-broke-student-out) to help a broke student out or at the bottom of the page. :)

[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)

***DISCLAIMER***
The project is still in its beta/testing state.
Proceed at your own risk, I shall not take responsibility for any damages caused.

### For quick post installation, please run this in terminal:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/onekey_installer.sh)"
```

## My Matebook X Pro's Hardware Configuration:
- CPU: i7-8550U @ 1.8GHz
- 16GB RAM
- Nvidia MX 150 / Intel UHD 620
- 3K display @ 3000x2000
- 512 Gb Toshiba SSD
- USB Wifi: Edimax N150 (2.4 GHz only but cheap) / [Edimax AC1200 (2.4 + 5GHz)](https://www.amazon.com/gp/product/B01MY7PL10/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1)
- Builtin Bluetooth: Intel Wireless Bluetooth 8275

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
- HDMI 2.0 support, up to two 4K @60Hz monitors. 

## What doesn't Work:
- dGPU (Nvidia Optimus not supported on MacOS)
- eGPU (not tested)
- Fingerprint Sensor
- Intel Wifi (soldered onto the motherbaord)
- As of right now, Samgsung PM981 SSDs are not supported.

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

## Installing Without A MacOS Device

If you don't have a machine running MacOS, you can easily create your bootable USB following these steps:

1. Download [gibMacOS Scripts](https://github.com/corpnewt/gibMacOS)
2. Run `gibMacOS.bat`
3. Run `MakeInstall.bat`
4. Copy clover files from this repo onto your USB
> You can copy over any WiFi dongle drivers or tools you may need onto your USB for post installation
5. Boot from USB and select `"Boot macOS install from OS X Base System"`
6. System will reboot choose option `"Boot macOS from <your_drive_name>"`

Just follow through the steps and you should be good to go.

## Post Installation

Please run this code in terminal:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/onekey_installer.sh)"
```

You should now be at your desktop.

Download
- [Clover Configurator Pro](https://github.com/Micky1979/Clover-Configurator-Pro/blob/master/Updates/CCP_v1.4.1.zip?raw=true)
- USB Wi-fi Drivers
- Newest [Clover Bootloader](https://sourceforge.net/projects/cloverefiboot/), and install it to your boot disk

Mount EFI partition if not mounted already

Clone the repository via terminal or download it and swap the CLOVER folder downloaded for the one in your EFI directory.

***Note if you have the i5 version, or any other configurations of the laptop sold exclusively in China***, you should:
- For i5 models: you have to make a custom CPUFriendProvider for Power Management by following [this](https://github.com/stevezhengshiqi/one-key-cpufriend) guide:
	
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

## Dual Booting Fix

After Windows updates, Clover EFI might be ignored making your system boot straight to Windows.
This is usually caused by a Windows update affecting EFI files. Here's how to fix it:

1. Grab the [gibMacOS Scripts](https://github.com/corpnewt/gibMacOS)
2. Run `MakeInstall.bat`
3. Choose to install clover only in the script - for example, if your drive number is `1` then enter `1C` for the `MakeInstall.bat` script and press enter
4. Boot from your USB that you installed Clover to and go to MacOS
5. Mount your boot disk EFI partition using Clover Configurator
6. In `EFI/Microsoft` or `EFI/Windows` rename the boot EFIs (`boot.efi` and `bootmgfw.efi`) to `<original_name>-orig.efi`.

That's it! Dual boot should be fixed.

## Activate Surround Sound via MIDI
1. Open Audio MIDI Setup from applications
2. Click on the "+" symbol on the bottom left corner
3. Click "Create Muti-Output Device"
4. Check both of the Built-in Output options 
5. Select the newly created device in the menu bar
6. Enjoy your music!

> (Note, there is no volume control for multi-channel devices in macOS, so in order to change the volume, you'd have to change the individual volume on each output, or get dedicated software)

## Bluetooth Fix (Deprecated)

Before any of this, make sure you have bluetooth avaliable in the menu, even if it says no hardware detected

1. Download: [VMware](https://www.vmware.com/go/getfusion), and Tinycorelinux [Core.iso](http://tinycorelinux.net/10.x/x86/release/Core-10.1.iso)  
2. Boot the iso file with VMware  
3. Run the following command in terminal: 
```
$ tce-load -wil bluez usbutils firmware-intel  
```  
4. From the Core's Bluetooth settings, uncheck "Share Bluetooth devices with Linux"  
5. Now, you should see Intel Bluetooth in the list of devices above  
6. Check the Intel Bluetooth box and wait for about 4-5 seconds, during this time, the check may flicker, this is ok  
7. Then uncheck the box, and you should see bluetooth is now avaliable to macOS.

> Instead of shutting down the VM, pause it and quit VMware. This saves you trouble of having to re-type the command each time, just repeat steps 4 - 7.

# Updates

### 1/1/2020: Update of the Decade (I've worked really really hard on this one, so please feel free to help a broke student out [here](https://github.com/gnodipac886/MatebookXPro-hackintosh#help-a-broke-student-out))
- Fixed battery draining during sleep cause by bluetooth chip
- Fixed battery draining issue by adding a custom SSDT-DDGPU to turn off the MX150
- Added SSDT-DRP11 in order to turn off the currently unsupported Intel Wifi card (there's a substantial effort in developing an Intel Wifi card)
- Added IntelBluetoothFirmware.kext[Link](https://github.com/zxystd/IntelBluetoothFirmware)
1. Enables bluetooth firmware loading on cold boot
2. Allows bluetooth on/off in menu bar and settings
- Redid the ALC265 codec support on the MXP
1. Added support for multi channels in order to use 4/4 speakers on the Matebook X Pro. (Tutorial [link](https://github.com/gnodipac886/MatebookXPro-hackintosh#activate-surround-sound-via-midi)
2. Added support for headset mic line in, (please select that in settings if you would like to headset mic)
3. Fixed volume mute button
- Fixed USB properties

### 11/1/2019: 10.15 Catalina
- Updated Kexts for Catalina support
- Updated clover version for Catalina support
- Adjusted brightness control method for Catalina support

### 7/1/2019: Pretty Small Update
- Trackpad drivers updated
- NoTouchID updated
- You can now load bluetooth firmware in macOS without booting into windows. [Source](https://osxlatitude.com/forums/topic/10127-updated-nov-2017-fix-btfirmwareuploader-in-macos-high-sierra/)
(Before any of this, make sure you have bluetooth avaliable in the menu, even if it says no hardware detected)
	1. Download: [VMware](https://www.vmware.com/go/getfusion), and Tinycorelinux [Core.iso](http://tinycorelinux.net/10.x/x86/release/Core-10.1.iso)
	2. Boot the iso file with VMware
	3. Run the following command in terminal: 
	```
	tce-load -wil bluez usbutils firmware-intel

	```
	4. From the Core's Bluetooth settings, uncheck "Share Bluetooth devices with Linux"
	5. Now, you should see Intel Bluetooth in the list of devices above
	6. Check the Intel Bluetooth box and wait for about 4-5 seconds, during this time, the check may flicker, this is ok
	7. Then uncheck the box, and you should see bluetooth is now avaliable to macOS.
- Still working on optimizing battery, you may try patching DSDT with the common DSDT patches mentioned [here](https://www.tonymacx86.com/threads/guide-patching-laptop-dsdt-ssdts.152573/) to get a better idea.

### 6/1/2019: Pretty big update
- New Autoinstaller that just installs everything for you in jsut one click (EFI partition NEEDS to be disk0s1)
- We now use SSDT hotpatch for everything (no DSDT patching needed, plug and play)
- iMessage, Facetime, and Siri now work again (you do need to inject system definition: follow this [tutorial](https://www.tonymacx86.com/threads/an-idiots-guide-to-imessage.196827/))
- Now supports up to two 4k@60hz monitors
- New platform ID for better support (4k monitors etc. (ID: 0x591C0005))
- Disable hibernation mode in script
- You can now turn Bluetooth on and off (Credit carson_zsy)
- New USB installation CLOVER folder for USB install
- You can directly update to 14.5 now with out any plist swap
- Update clover version
- Updated Lilu
- Updated VituralSMC
- Updated Whatevergreen
- Updated AppleALC

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
