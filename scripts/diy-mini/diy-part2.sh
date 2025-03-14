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
sed -i 's/192.168.1.1/$LAN_IP/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/$LAN_IP/g' package/base-files/luci2/bin/config_generate
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
