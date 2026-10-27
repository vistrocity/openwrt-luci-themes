#
# luci-theme-__SLUG__ - __NAME__ LuCI theme
# Derived from luci-theme-bootstrap (Apache-2.0).
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=__TITLE__
LUCI_DEPENDS:=+luci-base

PKG_LICENSE:=Apache-2.0

define Package/luci-theme-__SLUG__/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.__NAME__
	uci commit luci
}
endef

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
