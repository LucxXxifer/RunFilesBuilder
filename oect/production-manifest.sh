#!/bin/sh
set -eu

release_tag="${1:-manual}"
artifact_class="${2:-scaffold}"
generated_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
source_commit="$(git rev-parse --verify HEAD^{commit})"
upstream_commit="$(git ls-remote https://github.com/wukongdaily/RunFilesBuilder.git refs/heads/master | awk '{print $1}')"
[ -n "$upstream_commit" ] || upstream_commit="unknown"

whitelist_json="$(awk 'NF && $1 !~ /^#/ { printf "%s\"%s\"", sep, $1; sep=", " }' oect/whitelist.txt)"

cat <<JSON
{
  "name": "oect-runfiles",
  "release_tag": "$release_tag",
  "generated_at": "$generated_at",
  "artifact_class": "$artifact_class",
  "source_repo": "LucxXxifer/RunFilesBuilder",
  "source_commit": "$source_commit",
  "upstream_repo": "wukongdaily/RunFilesBuilder",
  "upstream_master_commit": "$upstream_commit",
  "whitelist": [$whitelist_json],
  "target": {
    "openwrt_release": "24.10.x",
    "package_manager": "opkg"
  },
  "contains_private_identity": false,
  "explicitly_excluded": [
    "tailscaled.state",
    "tailscale auth key",
    "ShellCrash subscription",
    "CrashCore runtime",
    "Lucky certificate/token/domain",
    "root password hash",
    "SSH private key"
  ],
  "notes": [
    "This production line only packages whitelisted artifacts.",
    "wkccd/CloudRunFilesBuilder DailyBuild releases are not used as a trusted baseline.",
    "Installers must run inside OpenWrt/iStoreOS, not on the fnOS host."
  ]
}
JSON
