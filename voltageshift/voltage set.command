#!/bin/bash
cd downloads
cd voltageshift
sudo chown -R root:wheel VoltageShift.kext
sudo -S ./voltageshift offset -100 -50 -90
osascript -e 'tell application "Terminal" to quit' &
