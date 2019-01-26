# 华为 Matebook X Pro 黑苹果教程

### 钱要是嫌多的话可以在最下面给我捐点爱心. :)

[English](README.md) | [中文](README-CN.md)| [Español](README-ESP.md)

***免责声明***
这个项目还在测试阶段，如果您有任何损坏，我将不承担任何责任。

## 我的硬件配置:
- CPU: i7-8550U @ 1.8GHz
- 内存：16GB
- Nvidia GTX MX 150 / Intel UHD 620
- 3K 显示屏 @ 3000x2000
- 512 Gb 东芝固态硬盘 (Not tested on Liteon SSDs yet)
- USB Wifi: Edimax N150

## 能用的功能:
- CFL 显卡驱动
- Applealc 声卡
- 键盘音量控制
- 摄像机
- 触摸板
- 多指触屏
- 电池
- 热起蓝牙
- 能源管理
- U 盘 Wi-Fi

## 不能用的功能:
- 亮度调节以及睡眠
- MX 150
- 外界显卡（没测试过）
- 指纹识别
- 英特尔网卡

## 开始吧

### 需要的工具:
- 华为 Matebook X Pro (i7 和 i5 都可以)
- macOS 景象
- 8GB U盘
- USB 网卡
- USB C 转 USB A 

### BIOS 设置
- 按 f2 键进BIOS
- 还原
- 取消安全启动

## 安装前:
装系统之前最好Windows的文件保存一下

要想保留Windows 系统的话也可以：
http://www.tonymacx86.com/multi-booting/133940-mavericks-windows-8-same-drive-without-erasing.html

用这个教程做USB引导: 
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

用rehabman的HD620 config.plist

***为了做引导，把 config.plist/Graphics/ig-platform-id 设为 0x12345678.***

要是你重装了windows的话，指纹可能不好用了，得重装驱动:
http://bradshacks.com/matebook-x-pro-fingerprint/

按照第二张帖子装mac系统:
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

## 安装后：

你现在应该在桌面。

下载：
- Clover Configurator Pro
	https://github.com/Micky1979/Clover-Configurator-Pro/blob/master/Updates/CCP_v1.4.1.zip?raw=true
- USB Wi-fi 驱动软件
- 最新的Clover：
	https://sourceforge.net/projects/cloverefiboot/

加载EFI

下载我的github上的文件
***您要是有中国产的华为你几本的话***, 您应该:
- 删除 DSDT.aml 文件 ： /Volumes/EFI/EFI/CLOVER/ACPI/patched 生成你自己的dsdt.
- i5的用户，请自己生成能源管理的kext。
	https://github.com/PMheart/CPUFriend/blob/master/Instructions.md
	
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

你现在该有个能用的黑苹果. 

常见为题:
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

| PayPal                                                     | Venmo.                                                     | WeChat                                               |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| ![PayPal_160]( https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/paypal.png?raw=true) | ![venmo_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/venmo.jpg?raw=true) | ![Wechat_160](https://github.com/gnodipac886/MatebookXPro-hackintosh/blob/master/Help%20a%20Broke%20Student%20out/WeChat.jpg) |

祝您好运!
