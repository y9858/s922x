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
git clone --depth 1 https://github.com/y9858/luci-theme-opentomcat package/luci-theme-opentomcat
sed -i 's/luci-theme-bootstrap/luci-theme-opentomcat/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ttyd 免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# Add luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall-packages

# Add luci-app-openclash
git clone -b master --depth 1 https://github.com/y9858/OpenClash package/luci-app-openclash

# Add luci-app-unblockneteasemusic
git clone -b master --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua

# Add luci-app-amlogic
git clone --depth 1 https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic

# Add luci-app-mosdns
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
find ./ | grep Makefile | grep v2dat | xargs rm -f
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns
git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

rm -rf ./package/network/services/dnsmasq
git clone --depth 1 https://github.com/y9858/dnsmasq package/network/services/dnsmasq

rm -rf ./package/libs/openssl
git clone --depth 1 https://github.com/y9858/openssl package/libs/openssl

rm -rf ./package/lean/autocore/files/arm/sbin
git clone --depth 1 https://github.com/y9858/sbin package/lean/autocore/files/arm/sbin

rm -rf ./feeds/packages/net/tailscale
git clone --depth 1 https://github.com/y9858/tailscale feeds/packages/net/tailscale
