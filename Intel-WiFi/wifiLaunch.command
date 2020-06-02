#!/bin/bash
BASEDIR=$(dirname $0)
cd ${BASEDIR}
unzip -q AppleIntelWiFi.kext-0523.zip
rm -r __MACOSX
cd AppleIntelWiFi.kext/Contents/
# open Info.plist
echo Type in WiFi name in exact format:
read wifiName
echo Type in WiFi password:
read -s wifiPass

/usr/libexec/PlistBuddy -c "Set :IOKitPersonalities:AppleIntelWiFi:IFConfig:NWID $wifiName" ~/Desktop/AppleIntelWiFi.kext/Contents/Info.plist
/usr/libexec/PlistBuddy -c "Set :IOKitPersonalities:AppleIntelWiFi:IFConfig:WPAKEY $wifiPass" ~/Desktop/AppleIntelWiFi.kext/Contents/Info.plist

cd ${BASEDIR}
rm -r AppleIntelWiFi.kext-0523.zip
zip -r -q AppleIntelWiFi.kext-0523.zip AppleIntelWiFi.kext

sudo mv ./AppleIntelWiFi.kext /tmp
sudo chown -R root:wheel /tmp/AppleIntelWiFi.kext
sudo kextload /tmp/AppleIntelWiFi.kext 
