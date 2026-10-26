#!/bin/sh
# Install a theme from GitHub straight onto an OpenWrt router.
#
#   sh install.sh <theme>            theme = obsidian | glass | mission | blueprint | terminal | brutal | synthwave | paper | retro
#
# Public repo:
#   wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s mission
# Private repo (needs a read-only fine-grained token with "Contents: read"):
#   export GITHUB_TOKEN=github_pat_xxx
#   wget -qO- --header="Authorization: Bearer $GITHUB_TOKEN" \
#     https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s mission
set -e
THEME="${1:-}"
REPO="vistrocity/openwrt-luci-themes"
case "$THEME" in obsidian|glass|mission|blueprint|terminal|brutal|synthwave|paper|retro|rack|circadian|teletext|pixel|aquarium|sumie|topo) ;; *) echo "usage: sh install.sh obsidian|glass|mission|blueprint|terminal|brutal|synthwave|paper|retro|rack|circadian|teletext|pixel|aquarium|sumie|topo"; exit 1;; esac

TMP=/tmp/owt-install.$$
mkdir -p "$TMP" && cd "$TMP"
trap 'cd /; rm -rf "$TMP"' EXIT

if [ -n "$GITHUB_TOKEN" ]; then
	URL="https://api.github.com/repos/$REPO/tarball/main"
	wget -q --header="Authorization: Bearer $GITHUB_TOKEN" -O repo.tgz "$URL"
else
	wget -q -O repo.tgz "https://codeload.github.com/$REPO/tar.gz/refs/heads/main"
fi

tar -xzf repo.tgz
SRC="$(ls -d */luci-theme-$THEME 2>/dev/null | head -n1)"
[ -n "$SRC" ] || { echo "luci-theme-$THEME not found in download"; exit 1; }
sh "$SRC/install.sh"
