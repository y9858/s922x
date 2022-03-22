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

# Modify default theme
cd feeds/luci/themes
rm -rf luci-theme-argon
cd ../../..
git clone -b revert-271-18.06_bing https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Add luci-app-bypass
git clone https://github.com/kiddin9/openwrt-bypass package/luci-app-bypass
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall

# Add luci-app-dockerman
cd feeds/luci/applications
rm -rf luci-app-dockerman
cd ../../..
git clone https://github.com/lisaac/luci-app-dockerman package/luci-app-dockerman

# Add luci-app-unblockneteasemusic
cd feeds/luci/applications
rm -rf luci-app-unblockmusic
cd ../../..
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic

# Add luci-app-dnsfilter
git clone https://github.com/kiddin9/luci-app-dnsfilter package/luci-app-dnsfilter

# Add luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release
