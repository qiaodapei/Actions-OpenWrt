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
#
# 修改openwrt登陆地址,把下面的 192.168.10.1 修改成你想要的就可以了
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改子网掩码
#sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}
# 移除 bootstrap 主题
sed -i 's/CONFIG_PACKAGE_luci-theme-bootstrap=y/CONFIG_PACKAGE_luci-theme-bootstrap=n/' .config

# 添加额外插件
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata

# 科学上网插件
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# Themes
git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 -b master https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 晶晨宝盒
git_sparse_clone main https://github.com/ophub/luci-app-amlogic luci-app-amlogic
sed -i "s|firmware_repo.*|firmware_repo 'https://github.com/haiibo/OpenWrt'|g" package/luci-app-amlogic/root/etc/config/amlogic
# sed -i "s|kernel_path.*|kernel_path 'https://github.com/ophub/kernel'|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|ARMv8_MINI|g" package/luci-app-amlogic/root/etc/config/amlogic

# SmartDNS
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

# MosDNS
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

# iStore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci

# quickstart
# git_sparse_clone master https://github.com/linkease/nas-packages.git nas 
# git_sparse_clone main   https://github.com/linkease/nas-packages-luci.git nas_luci

# 在线用户
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by Loki/g" package/lean/default-settings/files/zzz-default-settings

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;


# 添加第三方应用
echo "
# 系统相关应用
CONFIG_PACKAGE_luci-app-poweroff=y
CONFIG_PACKAGE_luci-app-fileassistant=y
# CONFIG_PACKAGE_luci-app-guest-wifi=y
CONFIG_PACKAGE_luci-app-onliner=y
CONFIG_PACKAGE_luci-app-eqos=y
# CONFIG_PACKAGE_luci-app-wolplus=y
CONFIG_PACKAGE_luci-app-wifischedule=y
CONFIG_PACKAGE_luci-app-ramfree=y
# CONFIG_PACKAGE_luci-app-usb3disable=y
CONFIG_PACKAGE_luci-app-luci-app-netdata=y
CONFIG_PACKAGE_luci-app-luci-app-rtbwmon=y

# 存储相关应用
# CONFIG_PACKAGE_luci-app-gowebdav=y

# QuickStart 快速配置向导
CONFIG_PACKAGE_luci-app-quickstart=y
CONFIG_PACKAGE_luci-app-ddnsto=y
CONFIG_PACKAGE_linkease=y
CONFIG_PACKAGE_luci-lib-ipkg=y
CONFIG_PACKAGE_wget-ssl=y
CONFIG_PACKAGE_curl=y

" >> .config

# 额外组件
echo "
CONFIG_GRUB_IMAGES=y
CONFIG_VMDK_IMAGES=y
" >> .config


cat .config

./scripts/feeds update -a
./scripts/feeds install -a
