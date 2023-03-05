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
git clone https://github.com/y9858/luci-theme-opentomcat package/luci-theme-opentomcat
sed -i 's/luci-theme-bootstrap/luci-theme-opentomcat/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ttyd 免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# bash 替换 ash
sed -i "36i sed -i '1s/ash/bash/' /etc/passwd" package/lean/default-settings/files/zzz-default-settings

# Modify luci-app-turboacc
sed -i '2s/Turbo ACC 网络加速/网络加速/' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

# Add luci-app-passwall2
svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall

# Add luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
