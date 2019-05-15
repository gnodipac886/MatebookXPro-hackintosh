# Matebook X Pro Hackintosh
This is the guide to install macOS onto the Huawei Matebook X Pro without requiring any MacOS device.

## Credits  
The guide below is based on Shaneee's guide on the [AMD-OSX](https://forum.amd-osx.com/viewtopic.php?p=44939#p44939) website.


## Pre-requisites
Softwares you need to get started:  
1. [Boot Disk Utility](http://cvad-mac.narod.ru/index/bootdiskutility_exe/0-5)
2. [TransMac](https://www.acutesystems.com/scrtm.htm)
3. [Paragon HardDisk Manager](https://www.paragon-software.com/free/pm-express/#resources)

Trial or free version of all the above programs should be good enough for our purpose.

4. Install MacOS App image, you can use the 10.14.1 version [provided by Shaneee on AMD-OSX here](https://drive.google.com/open?id=1JBpvwJqGQBreASe7avojmiYpeDDTyB64
).  
> _Note_: Starting with 10.14.1 will require updating later. Ask a friend with a Mac to download a more up to date Install MacOS App image.  

## Steps

1. Launch **Boot Disk Utility**   
a. Go to _**Options_.  
b. Click on _**Check Now**_ - this should detect the latest released version of clover.  
c. Exit _**Options**_ and now select your USB from the list under _**Destination Disk_.  
d. Click on _**Format_, this can take a few moments to complete, it will say "All Done" when complete.  
e. Click on _**Tools**_ from the top menu, from the drop down select _**Extract HFS(HFS+) partition from DMG-files**_  
f. Navigate to where you downloaded the _**Install MacOS App**_ image - within the app image folder go to _**Install macOS Mojave.app\Contents\SharedSupport**_ and select  _**BaseSystem.dmg**_  
g. A terminal windows should popup and create _**4.hfs**_ in _**Install macOS Mojave.app\Contents\SharedSupport**_  
h. Expand your USB and select _**Part2**_ from the dropdown.  
i. Click _**Restore**_ and navigate to the _**4.hfs**_ file created above.

> _Note_: To activate Paragon HardDisk Manager you can sign up using your email - there shouldn't be any payment required.

2. Launch **Paragon HardDisk Manager**  
a. Go to the second tab in the top menu.  
b. You should see your USB listed below.  
c. Select the second partition on your USB and drag it to the end of the _**(Unallocated)**_ space.   
d. Hit apply in the top left of the window

3. Launch **TransMac** (as an Administrator)  
a. Select _**Tools**_ from the top menu bar  
b. Go to _**Settings**_ from the dropdown  
c. Select the _**Disk Drives**_ tab from the new window  
d. Select the _**Access non-removable drives read/write (use with caution)**_ option, and then click _**OK**_ to exit the window
e. Locate your USB in the left sidebar and navigate to _**OS X Base System/Install macOS Mojave.app/Contents**_  
f. Right-click in the empty space in the main window and select _**Copy Here**_
g. Navigate to _**Install macOS Mojave.app\Contents**_ and select the _**SharedSupport**_ folder
h. This should start copying the folder to your USB - this might take a while to complete.

4. Customize your Clover Configuration  
a. For our use case, you can [download this repo](https://github.com/gnodipac886/MatebookXPro-hackintosh/archive/master.zip)  
b. Extract the downloaded ZIP and copy the contents of the _**Clover**_ folder to _**/EFI/EFI/CLOVER/**_

> _Note:_ The path _**/EFI/EFI/CLOVER**_ refers to the EFI partition which contains an EFI folder.

5. Configure [BIOS as listed in the README](https://github.com/gnodipac886/MatebookXPro-hackintosh#bios-settings)

> _Note:_ BIOS v1.26 temporarily broke support for Liteon SSD, make sure to update to v1.28 or newer - this can be done using PC Manager or manually from the [Huawei Support website](https://consumer.huawei.com/us/support/pc/matebook-x-pro/)

6. Boot to the UEFI partition of your USB.  

> _Note:_ If the name of your USB is _**MACOS USB**_ then select _**EFI : MACOS USB**_ as your boot option

7. Installation  
a. After the installer boots, open Disk Utility  
b. Your SSD should show up in the left sidebar   
c. Select _**View All Devices**_ from the top left button  
d. Select the top-level name for your SSD and then click erase  
e. Give a name of you choice for the disk, you can use _**macOS Extended (Journaled)**_ format, and a _**GUID Partition Map**_  
f. Exit Disk Utility after erasing is done
g. Select _**Reinstall macOS**_, let the installation complete  
h. Once installation is done, select _**Install macOS from <your_disk_name>**_ from the Clover screen  
i. Installation should complete and should boot to the macOS desktop

8. Post Installation  
a. Download [Clover Installer](https://sourceforge.net/projects/cloverefiboot/)  
b. Install Clover to your SSD - make sure to customize the installation and select _**Install for UEFI**_  
c. Once the installation is complete, you can copy the Clover from your USB to overwrite the Clover installation on your SSD.  
d. Eject USB and reboot from SSD.

**CONGRATS, YOU'RE ALL DONE**
