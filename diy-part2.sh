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
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat package/luci-theme-opentomcat
git clone https://github.com/Leo-Jo-My/luci-theme-argon-dark-mod package/luci-theme-argon-dark-mod
git clone https://github.com/Leo-Jo-My/luci-theme-Butterfly-dark package/luci-theme-Butterfly-dark
git clone https://github.com/Leo-Jo-My/luci-theme-opentomato package/luci-theme-opentomato
git clone https://github.com/Leo-Jo-My/luci-theme-Butterfly package/luci-theme-Butterfly
git clone https://github.com/Leo-Jo-My/luci-theme-argon-mod package/luci-theme-argon-mod
git clone https://github.com/Leo-Jo-My/luci-theme-argon-light-mod package/luci-theme-argon-light-mod
git clone https://github.com/Leo-Jo-My/luci-theme-leo package/luci-theme-leo
sed -i 's/luci-theme-bootstrap/luci-theme-opentomcat/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Add v2raya
svn co https://github.com/fw876/helloworld/trunk/v2raya package/v2raya
svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core

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

# Add luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release
