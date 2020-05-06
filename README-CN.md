# 华为 Matebook X Pro 黑苹果教程

### 钱要是嫌多的话可以在[这里](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/README-CN.md#帮帮我呗)，或最下面给我捐点爱心. :) 

### QQ 群号： 812158410

[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)

***免责声明：***
- 这个项目还在测试阶段，如果您有任何损坏，我将不承担任何责任。

## 我的硬件配置:
- CPU: i7-8550U @ 1.8GHz
- 内存：16GB
- Nvidia GTX MX 150 / Intel UHD 620
- 3K 显示屏 @ 3000x2000
- 512 Gb 东芝固态硬盘 (Not tested on Liteon SSDs yet)
亲测Liteon CA3 需修改KEXTS补丁：
	Name*: IONVMeFamily
	Find* [HEX]: f6c1100f 85410100 00
	Replace* [HEX]: f6c1020f 85410100 00
	Comment: IONVMeFamily Preferred Block Size 0x10 -> 0x02 (c) Pike R. Alpha implemented by syscl adapted for 10.13.x-10.14 by Ricky
	MatchOS: 10.14
- USB Wifi: Edimax N150

## 能用的功能:
- KBL 显卡驱动
- 睡眠
- 亮度调节
- Applealc 声卡
- 键盘音量控制
- 摄像机
- 触摸板
- 多指触屏
- 电池
- 蓝牙（需要先进入Windows系统，重启后选择macos才能生效）
- 能源管理
- U 盘 Wi-Fi

## 不能用的功能:
- MX 150
- 外界显卡（没测试过）
- 指纹识别
- 英特尔网卡

## 开始吧

### 需要的工具:
- 华为 Matebook X Pro (i7 和 i5 都可以)
- macOS 镜像
- 8GB U盘
- USB 网卡
- USB C 转 USB A 

### BIOS 设置
- 按 f2 键进BIOS
- 还原
- 取消安全启动

## 安装前:
使用华为管家，升级BIOS！！

装系统之前最好Windows的文件保存一下

要想保留Windows 系统的话也可以：
http://www.tonymacx86.com/multi-booting/133940-mavericks-windows-8-same-drive-without-erasing.html

用这个教程做USB引导: 
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

用rehabman的HD620 config.plist

***为了做引导，把 config.plist/Graphics/ig-platform-id 设为 0x12345678.***

要是您重装了windows的话，指纹可能不好用了，得重装驱动:
http://bradshacks.com/matebook-x-pro-fingerprint/

按照第二张帖子装mac系统:
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

## 安装后：

您现在应该在桌面。

下载：
- Clover Configurator Pro
	https://github.com/Micky1979/Clover-Configurator-Pro/blob/master/Updates/CCP_v1.4.1.zip?raw=true
- USB Wi-fi 驱动软件
- 最新的Clover：
	https://sourceforge.net/projects/cloverefiboot/

替换EFI

下载我的github上的文件
***您要是有中国产的华为笔记本的话***, 您应该:
- i5的用户，请自己生成能源管理的kext。
	https://github.com/stevezhengshiqi/one-key-cpufriend
	
### DSDT 修理
把下面的代码加入dsdt里面，修复键盘亮度调节.
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
重启

恭喜，您现在该有个能用的黑苹果. 


### 常见为题:
- 亮度调节不了: 下载 “brightness slider”
	https://itunes.apple.com/us/app/brightness-slider/id456624497?mt=12
- 睡眠用不了
- 蓝牙得从windows重启才能用

### 感谢:
- Darren_Pan on reddit
- midi and Maemo on discord
- Chinese Matebook X Pro Hackintosh community
- Spanish Matebook X Pro Hackintosh community
- All the developers who developed the kexts used in this guide.

# 更新：

### 1/1/2020: 新时代的更新 (我这次玩大了，累死了，希望可以给我[打赏](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/README-CN.md#帮帮我呗))
- 修复睡眠好点问题
- 修复电池续航问题：加了 SSDT-DDGPU
- 用SSDT-DRP11 关闭英特尔网卡
- 加了 IntelBluetoothFirmware.kext[链接](https://github.com/zxystd/IntelBluetoothFirmware)
1. 蓝牙可以冷启动了
2. 可以在系统里开关蓝牙
- 重新整理了声卡
1. 现在4个喇叭都可以用 (教程[链接](https://github.com/gnodipac886/MatebookXPro-hackintosh#activate-surround-sound-via-midi)
2. 可以使用耳麦
3. 修复了静音键
- 修复了USB

### 6/1/2019: 大更新
- 添加了自动安装脚本， 一键驱动 (EFI 必须是 disk0s1)
- 我们现在全用 hotpatch 打补丁 (不需要修改DSDT了)
- iMessage, Facetime, 和 Siri 现在可以用了 (你必须改三码： [教程](https://www.tonymacx86.com/threads/an-idiots-guide-to-imessage.196827/))
- 现在支持同时使用两个4k@60hz 的显示屏
- 现在我们用新的 platform ID (驱动4k 显示屏(ID: 0x591C0005))
- 在脚本里面添加了禁止休眠模式的代码
- 蓝牙现在可以用开关了 (Credit carson_zsy)
- 添加了新的U盘安装文件 （没测试过）
- 可以直接升级14.5， 不用替换config
- 更新了 clover
- 更新了 Lilu
- 更新了 VituralSMC
- 更新了 Whatevergreen
- 更新了 AppleALC

### 5/1/2019: 有史以来最重要的更新
- KBL 亮度调节
- 自动亮度调节
- 睡眠
- KBL 七代的核显
- 声卡驱动更新
- WhatEverGreen 更新至 1.2.8
- VoodooI2C 更新
- 你需要修改 DSDT 才能用触摸板，以及键盘控制亮度

### 4/11/2019: New LiteOn Patch
- 要是你有困难升级到 10.14.4， 请使用以下的补丁
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
### 1/21/2019
- 新的whatevergreen
- Lilu 更新
- Applealc
- 特别定制的触摸板驱动
- config.plist 简略修改

### 1/23/2019 : 10.14.3 更新
- New 10.14.3 显卡驱动布丁
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

### 帮帮我呗:
- PayPal:
    https://www.paypal.me/gnodipac886#%20MatebookXPro-hackintosh
- Venmo:
    https://venmo.com/code?user_id=2386577070227456090

QR Codes:

| 支付宝                                                     | PayPal                                                     | Venmo.                                                     | 微信                                               |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| ![支付宝_160]( https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E6%94%AF%E4%BB%98%E5%AE%9D.jpg) | ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://raw.githubusercontent.com/gnodipac886/MatebookXPro-hackintosh/master/Help%20a%20Broke%20Student%20out/%E5%BE%AE%E4%BF%A1%E6%94%AF%E4%BB%98.jpg) |


祝您好运!
