#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# 读取环境变量
echo "✅ 当前 LAN IP 地址设置为：$LAN_IP"
echo "✅ 系统名称设置为：$OS_NAME"
echo "✅ WiFi 状态设置为：$ENABLE_WIFI"
# 修改默认IP
sed -i "s|192.168.1.1|${LAN_IP}|g" package/base-files/files/bin/config_generate
sed -i "s|192.168.1.1|${LAN_IP}|g" package/base-files/luci2/bin/config_generate
# sed -i 's/192.168.1.1/$LAN_IP/g' package/base-files/files/bin/config_generate
# sed -i 's/192.168.1.1/$LAN_IP/g' package/base-files/luci2/bin/config_generate
# 修改默认主机名为MiyaWrt
sed -i '/uci commit system/i\uci set system.@system[0].hostname='$OS_NAME'' package/lean/default-settings/files/zzz-default-settings
sed -i "13i uci set network.lan.ifname='eth1 eth2 eth3'" package/lean/default-settings/files/zzz-default-settings
sed -i "14i uci set network.wan.ifname='eth0'" package/lean/default-settings/files/zzz-default-settings
# sed -i '13i uci set network.lan.ifname=''eth1 eth2 eth3'' package/lean/default-settings/files/zzz-default-settings
# sed -i '14i uci set network.wan.ifname='eth0'' package/lean/default-settings/files/zzz-default-settings
# 修改默认主题
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" feeds/luci/collections/luci/Makefile
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" feeds/luci/collections/luci-light/Makefile

# rm -rf feeds/packages/lang/golang
# git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 添加第三方应用
mkdir kiddin9
pushd kiddin9
git clone --depth=1 https://github.com/kiddin9/kwrt-packages .
popd

mkdir package/community
pushd package/community

#Onliner
mkdir luci-app-onliner
cp -rf ../../kiddin9/luci-app-onliner/* luci-app-onliner

#RAMfree
mkdir luci-app-ramfree
cp -rf ../../kiddin9/luci-app-ramfree/* luci-app-ramfree

#NetData（系统监控）
mkdir luci-app-netdata
cp -rf ../../kiddin9/luci-app-netdata/* luci-app-netdata
#rtbwmon（实施流量）
mkdir luci-app-rtbwmon
cp -rf ../../kiddin9/luci-app-rtbwmon/* luci-app-rtbwmon

# mkdir luci-app-guest-wifi
# cp -rf ../../kiddin9/luci-app-guest-wifi/* luci-app-guest-wifi

# poweroff关机插件
git clone https://github.com/DongyangHu/luci-app-poweroff.git

# 应用过滤(OAF)
git clone https://github.com/destan19/OpenAppFilter.git

popd

# 添加第三方应用
echo "
###################################################
# 系统相关应用
###################################################
CONFIG_PACKAGE_luci-app-poweroff=y
# CONFIG_PACKAGE_luci-app-guest-wifi=y
# CONFIG_PACKAGE_luci-app-wolplus=y
# CONFIG_PACKAGE_luci-app-usb3disable=y
################################################
# 状态相关应用
################################################
# 实时信息插件
CONFIG_PACKAGE_luci-app-rtbwmon=y
CONFIG_PACKAGE_rtbwmon=y
# luci-app-netdata可控制的实时监控
CONFIG_PACKAGE_netdata=y
CONFIG_PACKAGE_luci-app-netdata=y
# 释放内存插件
CONFIG_PACKAGE_luci-app-ramfree=y
# 在线用户插件
CONFIG_PACKAGE_luci-app-onliner=y
###############################################
# 服务相关应用
###############################################
# Wi-Fi 连接的时间表工具
CONFIG_PACKAGE_luci-app-wifischedule=y
###############################################
# 存储相关应用
###############################################
# Go WebDAV 应用，提供 WebDAV 服务的 Go 语言实现。
CONFIG_PACKAGE_luci-app-gowebdav=y
# 文件助手
CONFIG_PACKAGE_luci-app-fileassistant=y
##############################################
# 网络相关应用
##############################################
# 插件：应用过滤
CONFIG_PACKAGE_luci-app-oaf=y
# Socat插件
CONFIG_PACKAGE_luci-app-socat=y
# IP限速
CONFIG_PACKAGE_luci-app-eqos=y

" >> .config
