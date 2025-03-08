#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default
# echo 'src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome' >>feeds.conf.default
# echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
# echo 'src-git kiddin9 https://github.com/kiddin9/kwrt-packages' >>feeds.conf
# 添加 Passwall2 的软件源到 feeds 列表
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git' >> feeds.conf.default
echo 'src-git  passwall https://github.com/xiaorouji/openwrt-passwall.git;main' >> feeds.conf.default

# 直接使用 packages 官方源（覆盖原默认配置）
sed -i '/src-git-full packages/d' feeds.conf.default  # 删除原有 packages 源
echo 'src-git packages https://github.com/openwrt/packages.git;master' >> feeds.conf.default

