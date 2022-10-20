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
sed -i 's/luci-theme-bootstrap/luci-theme-atmaterial/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ttyd 免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# Add luci-app-passwall
git clone -b luci https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall

# Add luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-dockerman
git clone https://github.com/lisaac/luci-app-dockerman package/luci-app-dockerman

# Add luci-app-unblockneteasemusic
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
svn co https://github.com/immortalwrt/packages/trunk/multimedia/yt-dlp feeds/packages/multimedia/yt-dlp
sed -i 's#*/5#7#g' package/luci-app-unblockneteasemusic/root/etc/init.d/unblockneteasemusic
sed -i '89s/*/0/' package/luci-app-unblockneteasemusic/root/etc/init.d/unblockneteasemusic
sed -i 's/uclient-fetch/uclient-fetch +yt-dlp/g' package/luci-app-unblockneteasemusic/Makefile
sed -i 's/解除网易云音乐播放限制/网易云音乐/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua

# Add luci-app-dnsfilter
git clone https://github.com/kiddin9/luci-app-dnsfilter package/luci-app-dnsfilter

# Add luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic
