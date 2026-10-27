#!/bin/sh
# Rehearse the router install path without a router: packs this working tree like GitHub's tarball,
# runs the top-level install.sh against it (OWT_TARBALL) with a stubbed `uci`, and verifies the result.
#   tools/test-install.sh <slug> [slug...]
# It writes into /www and /usr/share/ucode of the machine it runs on, so use a throwaway container.
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
[ $# -ge 1 ] || { sed -n '2,5p' "$0"; exit 1; }
[ "${I_KNOW:-}" = 1 ] || [ ! -e /www/luci-static/bootstrap ] || { echo "refusing: looks like a real LuCI router (/www/luci-static/bootstrap exists)"; exit 1; }
W="$(mktemp -d)"; trap 'rm -rf "$W"' EXIT
mkdir -p "$W/bin" /www/luci-static/resources
cat > "$W/bin/uci" <<'STUB'
#!/bin/sh
echo "$*" >> "$UCI_LOG"
case "$1" in -q) [ "$2" = get ] && exit 1;; esac
exit 0
STUB
chmod +x "$W/bin/uci"
mkdir -p "$W/pack/openwrt-luci-themes-test"
( cd "$ROOT" && tar --exclude=.git -cf - . ) | ( cd "$W/pack/openwrt-luci-themes-test" && tar xf - )
tar -czf "$W/repo.tgz" -C "$W/pack" openwrt-luci-themes-test
export UCI_LOG="$W/uci.log" PATH="$W/bin:$PATH" OWT_TARBALL="$W/repo.tgz"
RC=0
for t in "$@"; do
	: > "$UCI_LOG"; echo "== install $t"
	sh "$ROOT/install.sh" "$t" || { echo "  FAIL installer exited non-zero"; RC=1; continue; }
	for p in "/www/luci-static/$t/cascade.css" "/www/luci-static/$t/mobile.css" "/www/luci-static/$t/logo.svg" "/www/luci-static/resources/menu-$t.js" \
		"/www/luci-static/resources/view/$t/sysauth.js" "/usr/share/ucode/luci/template/themes/$t/header.ut" \
		"/usr/share/ucode/luci/template/themes/$t/footer.ut" "/usr/share/ucode/luci/template/themes/$t/sysauth.ut"; do
		[ -s "$p" ] || { echo "  FAIL missing $p"; RC=1; }
	done
	grep -q "set luci.main.mediaurlbase=/luci-static/$t" "$UCI_LOG" || { echo "  FAIL mediaurlbase not set"; RC=1; }
	grep -qE "set luci.themes.[A-Za-z0-9]+=/luci-static/$t" "$UCI_LOG" || { echo "  FAIL theme not registered"; RC=1; }
	grep -q "commit luci" "$UCI_LOG" || { echo "  FAIL uci commit missing"; RC=1; }
	cmp -s "$ROOT/luci-theme-$t/htdocs/luci-static/$t/cascade.css" "/www/luci-static/$t/cascade.css" || { echo "  FAIL installed css differs from repo"; RC=1; }
done
echo "-- bad theme name must be refused:"; sh "$ROOT/install.sh" nope >/dev/null 2>&1 && { echo "  FAIL accepted unknown theme"; RC=1; } || echo "  ok"
[ $RC = 0 ] && echo "INSTALL TEST OK" || { echo "INSTALL TEST FAILED"; exit 1; }
