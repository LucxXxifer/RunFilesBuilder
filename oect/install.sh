#!/bin/sh
set -eu

[ -f /etc/openwrt_release ] || {
  echo "ERROR: this installer must run inside OpenWrt/iStoreOS, not fnOS host" >&2
  exit 10
}

. /etc/openwrt_release
case "${DISTRIB_RELEASE:-}" in
  24.10.*) ;;
  *) echo "ERROR: unsupported OpenWrt/iStoreOS release: ${DISTRIB_RELEASE:-unknown}" >&2; exit 11 ;;
esac

command -v opkg >/dev/null 2>&1 || {
  echo "ERROR: opkg not found" >&2
  exit 12
}

if command -v apk >/dev/null 2>&1; then
  echo "ERROR: apk-based system detected; this package is opkg-only" >&2
  exit 13
fi

opkg update
opkg install ./*.ipk
