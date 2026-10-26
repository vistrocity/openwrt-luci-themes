#
# luci-theme-pixel - 8-bit LuCI theme
# Derived from luci-theme-bootstrap (Apache-2.0).
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=8-bit Theme (pixel RPG)
LUCI_DEPENDS:=+luci-base

PKG_LICENSE:=Apache-2.0

define Package/luci-theme-pixel/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.Pixel
	uci commit luci
}
endef

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
