#!/bin/bash
BASEDIR=$(dirname $0)
cd ${BASEDIR}
unzip -q AppleIntelWiFi.kext-0523.zip
rm -r __MACOSX

sudo mv ./AppleIntelWiFi.kext /tmp
sudo chown -R root:wheel /tmp/AppleIntelWiFi.kext
sudo kextload /tmp/AppleIntelWiFi.kext 
rm -r AppleIntelWiFi.kext