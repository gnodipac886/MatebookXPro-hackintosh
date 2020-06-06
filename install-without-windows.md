# Installing macOS without a real Mac

> Adapted from [this comment](https://www.reddit.com/r/MatebookXPro/comments/gxdxlf/tried_out_the_hackintosh_on_my_mxp_2018/ft17vm7?utm_source=share&utm_medium=web2x) on reddit

1. Download gibMacOS-master.zip

2. Run: .\gibMacOS-master\gibMacOS.bat

3. Select option 1. It will download MacOS 10.15.5 (latest)

4. When it finishes, quit

5. Insert your USB drive and run the second script: .\gibMacOS-master\MakeInstall.bat

6. Choose the number that matches your USB drive (probably 1)

7. After accepting the warning, then it asks you for the recovery image. Put the full path in for this file: "C:\temp\gibMacOS-master\macOS Downloads\publicrelease\001-12336 - 10.15.5 macOS Catalina\RecoveryHDMetaDmg.pkg"

8. Be sure to add the quotes (" ") around the path.

9. Hit Enter and it will create a bootable drive. When it is done, quit.

10. Download gnodipac886's GitHub repo as a zip file. Unzip it and goto the folder: MatebookXPro-hackintosh-master\USB-EFI

11. In another Explorer window, open the USB drive (you should see something like a D: or E: drive with 200MB). Go in and open the "EFI" folder. Here, you should see two folders (BOOT, CLOVER).

12. Now, you want to copy the BOOT and CLOVER folders from the USB-EFI folder and overwrite the folders on the USB drive with the same name. Example:

13. USB-EFI\BOOT ==> E:\EFI\BOOT

14. USB-EFI\CLOVER ==> E:\EFI\CLOVER

Now you are ready to run the MacOS installer from the USB drive.

---

Once the install is completed, you will have a working install of MacOS, but it will not be bootable. You can boot the computer with the installer USB drive inserted and you will see 4 Apple Icons at the boot screen. Choose the new Mac install and it should boot to your Mac login screen. In order to make your Mac bootable without the install flash drive, you will need to copy those BOOT and CLOVER files over again (this time to the new drive).

Unfortunately, this is not a simple matter of copying like we did in step 11/12. The Mac EFI partition is hidden. You need to mount it with Clover Bootloader:

1. Download and install Clover Bootloader. This will add an icon up by the Clock.

2. Choose your disk (not install USB) and mount your drive, so that you can see the EFI partition.

3. Copy the BOOT and CLOVER files over to this partition (like we did in step 12 above).

4. Remove the installer USB drive and reboot. It should boot directly to MacOS.

---

Final Note: You will have a mostly working system, but there are a couple of things to beware of:

I did not use the onkeyinstaller. I can't comment on how well it will work for you and your specific situation.

After installing, you will have the same Mac serial number that is set in the config.plist that is in the package. You will need to use Clover Configurator Pro to create a new serial/hardware ID. If you don't do this, then services tied to Apple (like FindMyMac and iMessage) either won't work or could even be used by someone else.
