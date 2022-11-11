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
git clone https://github.com/Dawneng/luci-theme-atmaterial package/luci-theme-atmaterial
sed -i '309s/fff/0099CC/' package/luci-theme-atmaterial/htdocs/luci-static/atmaterial/css/style.css
sed -i '529d' package/luci-theme-atmaterial/htdocs/luci-static/atmaterial/css/style.css
sed -i 's/luci-theme-bootstrap/luci-theme-atmaterial/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ttyd 免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# Modify luci-app-unblockmusic
sed -i 's/解锁网易云灰色歌曲/网易云音乐/g' feeds/luci/applications/luci-app-unblockmusic/po/zh-cn/unblockmusic.po

# Add luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall

# Add luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman

# Add luci-app-mosdns
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/QiuSimons/openwrt-mos package/openwrt-mos

# Add luci-app-dnsfilter
#git clone https://github.com/kiddin9/luci-app-dnsfilter package/luci-app-dnsfilter

# Add luci-app-amlogic
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
