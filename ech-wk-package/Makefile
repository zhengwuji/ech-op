include $(TOPDIR)/rules.mk

PKG_NAME:=ech-wk
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=User <user@example.com>
PKG_LICENSE:=MIT

# Go package configuration
# If you have lang/golang/package.mk, use it. Otherwise, we can use a simpler approach.
# Assuming modern OpenWrt with Go support.
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/user/ech-wk
GO_PKG_LDFLAGS_X:=main.Version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
# Try to include golang package if available, otherwise manual build
-include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/ech-wk
  SECTION:=net
  CATEGORY:=Network
  TITLE:=ECH Workers Proxy
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/ech-wk/description
  ECH Workers Proxy Client
endef

define Package/ech-wk/conffiles
/etc/config/ech-wk
endef

define Package/luci-app-ech-wk
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI support for ech-wk
  DEPENDS:=+ech-wk +luci-base
endef

define Package/luci-app-ech-wk/description
  LuCI support for ech-wk
endef

# If golang-package.mk is not included, we need manual build instructions
ifndef GO_PKG_BUILD_BIN_DIR
  define Build/Compile
	cd $(PKG_BUILD_DIR)/src && \
	go build -o $(PKG_BUILD_DIR)/ech-wk .
  endef
endif

define Package/ech-wk/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ech-wk $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/ech-wk $(1)/etc/config/ech-wk
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/ech-wk $(1)/etc/init.d/ech-wk
endef

define Package/luci-app-ech-wk/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci/
	
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-ech-wk.json $(1)/usr/share/rpcd/acl.d/
endef

$(eval $(call BuildPackage,ech-wk))
$(eval $(call BuildPackage,luci-app-ech-wk))
