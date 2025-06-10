**测试固件，谨慎下载使用**  
**测试固件，谨慎下载使用**  
**测试固件，谨慎下载使用**
===cutline===
### 基本信息

默认 IP：192.168.1.99 | 默认密码：password

### 特别说明

- ImmortalWrt-18.06 固件由于代码太老，不包含 sing-box 核心。
- OpenWrt-24.10 及 ImmortalWrt-24.10 固件系统分区由 23.05 固件的 720M 调整为 820M 。
- N1-*-packages.zip 是 LEDE 和 iStoreOS 系统对应的用于部署本地 kmod 源的文件。使用下面的命令一键部署本地 kmod 源。
```bash
sh -c "$(curl -ksS https://testingcf.jsdelivr.net/gh/ffuqiangg/build_openwrt@main/files/deploy_feeds.sh)"
```

### 固件差异

|固件 \ 插件       |PassWall |OpenClash |V2rayA |HomeProxy |Nikki |DAED |
|:---              |:---:    |:---:     |:---:  |:---:     |:---: |:---:|
|ImmortalWrt-18.06 |⭕       |⭕        |⭕     |❌        |❌    |❌   |
|ImmortalWrt-24.10 |⭕       |❌        |⭕     |⭕        |⭕    |⭕   |
|Openwrt-24.10     |⭕       |❌        |⭕     |⭕        |⭕    |⭕   |
|LEDE              |⭕       |❌        |⭕     |❌        |⭕    |⭕   |
|iStoreOS-22.03    |⭕       |⭕        |⭕     |❌        |❌    |❌   |

### sing-box

sing-box 裸核相关脚本文件安装使用方法见 ⌈ [sing-box 安装使用文档](https://github.com/ffuqiangg/build_openwrt/blob/main/doc/sing-box_new.md) ⌋
