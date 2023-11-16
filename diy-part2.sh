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
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci-light/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# ttyd 免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# bash 替换 ash
[ ! -e "/bin/bash" ] || sed -i "23i sed -i '1s/ash/bash/' /etc/passwd" package/emortal/default-settings/files/99-default-settings

# Modify appname
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json

# Modify v2raya
sed -i 's/xray/v2ray/g' feeds/packages/net/v2raya/Makefile

# Add luci-app-amlogic
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i 's/+block-mount/+libuci-lua +lua +luci-compat +luci-lib-jsonc +block-mount/g' package/luci-app-amlogic/Makefile
