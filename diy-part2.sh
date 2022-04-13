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
rm -rf feeds/luci/themes/luci-theme-material
git clone https://github.com/LuttyYang/luci-theme-material package/luci-theme-material
sed -i 's/9. Themes/4. Themes/g' package/luci-theme-material/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Add luci-app-ssr-plus
git clone https://github.com/fw876/helloworld package/luci-app-ssr-plus
sed -i 's/Xray/V2ray/g' package/luci-app-ssr-plus/luci-app-ssr-plus/Makefile
sed -i 's/xray/v2ray/g' package/luci-app-ssr-plus/luci-app-ssr-plus/Makefile
sed -i '6d' package/luci-app-ssr-plus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client.lua
sed -i '5a m = Map("shadowsocksr", translate("ShadowSocksR Plus+ Settings"))' package/luci-app-ssr-plus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client.lua

# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt-package/branches/other/luci-app-adguardhome package/luci-app-adguardhome

# Add luci-app-smartdns
svn co https://github.com/immortalwrt/luci/branches/openwrt-18.06/applications/luci-app-smartdns package/luci-app-smartdns
sed -i '13d' package/luci-app-smartdns/Makefile
sei -i '12a include $(TOPDIR)/feeds/luci/luci.mk' package/luci-app-smartdns/Makefile

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
