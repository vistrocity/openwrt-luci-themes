#!/bin/sh
# Install a theme from GitHub straight onto an OpenWrt router.
#
#   sh install.sh <theme>
#   themes: rack blueprint teletext aquarium obsidian glass mission terminal synthwave pixel circadian brutal paper retro sumie topo handheld nixie subway chalkboard
#
# Public repo:
#   wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s aquarium
# Environment (all optional):
#   REF=<branch|tag>        install from another ref (default: main), e.g. a release branch for testing
#   GITHUB_TOKEN=<token>    read-only token, needed only while the repo is private
#   OWT_TARBALL=<file>      use a local repo tarball instead of downloading (offline installs, testing)
set -e
THEMES="rack blueprint teletext aquarium obsidian glass mission terminal synthwave pixel circadian brutal paper retro sumie topo handheld nixie subway chalkboard"
THEME="${1:-}"
REPO="vistrocity/openwrt-luci-themes"
REF="${REF:-main}"
case " $THEMES " in
	*" $THEME "*) [ -n "$THEME" ] || { echo "usage: sh install.sh <theme>   ($THEMES)"; exit 1; } ;;
	*) echo "usage: sh install.sh <theme>   ($THEMES)"; exit 1 ;;
esac

TMP=/tmp/owt-install.$$
mkdir -p "$TMP" && cd "$TMP"
trap 'cd /; rm -rf "$TMP"' EXIT

if [ -n "$OWT_TARBALL" ]; then
	cp "$OWT_TARBALL" repo.tgz
elif [ -n "$GITHUB_TOKEN" ]; then
	wget -q --header="Authorization: Bearer $GITHUB_TOKEN" -O repo.tgz "https://api.github.com/repos/$REPO/tarball/$REF"
else
	wget -q -O repo.tgz "https://codeload.github.com/$REPO/tar.gz/refs/heads/$REF" ||
		wget -q -O repo.tgz "https://codeload.github.com/$REPO/tar.gz/refs/tags/$REF"
fi

tar -xzf repo.tgz
SRC="$(ls -d */themes/luci-theme-$THEME */luci-theme-$THEME 2>/dev/null | head -n1)"
[ -n "$SRC" ] || { echo "luci-theme-$THEME not found in download"; exit 1; }
sh "$SRC/install.sh"
