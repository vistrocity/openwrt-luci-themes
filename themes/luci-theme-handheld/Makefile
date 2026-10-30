#
# luci-theme-handheld - Handheld LuCI theme
# Derived from luci-theme-bootstrap (Apache-2.0).
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Handheld Theme (four-shade LCD)
LUCI_DEPENDS:=+luci-base

PKG_LICENSE:=Apache-2.0

define Package/luci-theme-handheld/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.Handheld
	uci commit luci
}
endef

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
