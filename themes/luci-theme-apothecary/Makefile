#
# luci-theme-apothecary - Apothecary LuCI theme
# Derived from luci-theme-bootstrap (Apache-2.0).
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Apothecary Theme (pharmacy labels)
LUCI_DEPENDS:=+luci-base

PKG_LICENSE:=Apache-2.0

define Package/luci-theme-apothecary/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.Apothecary
	uci commit luci
}
endef

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
