#
# luci-theme-nixie - Nixie LuCI theme
# Derived from luci-theme-bootstrap (Apache-2.0).
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Nixie Theme (glow tubes on brass)
LUCI_DEPENDS:=+luci-base

PKG_LICENSE:=Apache-2.0

define Package/luci-theme-nixie/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.Nixie
	uci commit luci
}
endef

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
